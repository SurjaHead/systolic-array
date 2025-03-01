`default_nettype none

module systolic_array #(
    parameter SIZE = 3,         // Size of the weight matrix (SIZE×SIZE)
    parameter DATA_WIDTH = 16   // Bit width of weights and data
)(
    input wire clk,
    input wire reset,
    input wire load_weights,    // Signal to load weights
    
    // Weight loading interface
    input wire [DATA_WIDTH-1:0] weight_data,
    input wire [$clog2(SIZE*SIZE)-1:0] weight_mem, 
    
    // Input data interface
    input wire [DATA_WIDTH-1:0] input_data [0:SIZE-1],

    // Control signals
    input wire start,

    // Output data
    output wire [DATA_WIDTH-1:0] output_data [0:SIZE-1],
    output reg done
);

    // Internal signals
    reg [DATA_WIDTH-1:0] pe_weights [0:SIZE-1][0:SIZE-1];    // Weights stored in each PE
    wire [DATA_WIDTH-1:0] input_wires [0:SIZE][0:SIZE-1];    // Horizontal connections for inputs
    wire [DATA_WIDTH-1:0] psum_wires [0:SIZE-1][0:SIZE];     // Vertical connections for partial sums
    
    // Weight loading logic
    always @(posedge clk) begin
        if (load_weights) begin
            pe_weights[weight_mem/SIZE][weight_mem%SIZE] <= weight_data;
        end
    end
    
    // Connect input datas to the left edge of the array
    genvar i, j;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin: input_connections
            assign input_wires[i][0] = input_data[i];
        end
        
        // Initialize top row of partial sums to 0
        for (j = 0; j < SIZE; j = j + 1) begin: psum_init
            assign psum_wires[0][j] = 0;
        end
        
        // Create the processing element mesh
        for (i = 0; i < SIZE; i = i + 1) begin: pe_rows
            for (j = 0; j < SIZE; j = j + 1) begin: pe_cols
                weight_stationary_pe #(
                    .DATA_WIDTH(DATA_WIDTH)
                ) processing_element (
                    .clk(clk),
                    .reset(reset),
                    .weight(pe_weights[i][j]),
                    .input_in(input_wires[i][j]),
                    .psum_in(psum_wires[i][j]),
                    
                    .input_out(input_wires[i+1][j]),
                    .psum_out(psum_wires[i][j+1])
                );
            end
        end
        
        // Connect output datas
        for (j = 0; j < SIZE; j = j + 1) begin: output_connections
            assign output_data[j] = psum_wires[SIZE-1][j];
        end
    endgenerate
    
    // Control logic
    reg [$clog2(3*SIZE):0] cycle_counter;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cycle_counter <= 0;
            done <= 0;
        end else if (start) begin
            cycle_counter <= 0;
            done <= 0;
        end else if (cycle_counter < 3*SIZE - 1) begin
            cycle_counter <= cycle_counter + 1;
            done <= 0;
        end else begin
            done <= 1;
        end
    end

endmodule



