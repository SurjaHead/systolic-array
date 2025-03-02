module systolic_array #(parameter DATA_WIDTH=16) 
(
    input wire clk,
    input wire reset,
    input wire load_weights,
    input wire start,

    input wire [DATA_WIDTH-1:0] w11,
    input wire [DATA_WIDTH-1:0] w12,
    input wire [DATA_WIDTH-1:0] w21,
    input wire [DATA_WIDTH-1:0] w22,

    input wire [DATA_WIDTH-1:0] x11,
    input wire [DATA_WIDTH-1:0] x12,
    input wire [DATA_WIDTH-1:0] x21,
    input wire [DATA_WIDTH-1:0] x22,

    
)

endmodule