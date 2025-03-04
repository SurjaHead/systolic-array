module systolic_array #(parameter DATA_WIDTH=8) 
(
    input wire clk,
    input wire reset,
    input wire load_weights,
    input wire start,

    input wire [DATA_WIDTH-1:0] w00,
    input wire [DATA_WIDTH-1:0] w01,
    input wire [DATA_WIDTH-1:0] w10,
    input wire [DATA_WIDTH-1:0] w11,

    input wire [DATA_WIDTH-1:0] x0,
    input wire [DATA_WIDTH-1:0] x1,

    output wire [DATA_WIDTH-1:0] y0,
    output wire [DATA_WIDTH-1:0] y1,

    output reg done
);

   
    wire [DATA_WIDTH-1:0] input_inter0;
    wire [DATA_WIDTH-1:0] input_inter1;

    wire [DATA_WIDTH-1:0] psum_inter0;
    wire [DATA_WIDTH-1:0] psum_inter1;

     wire [DATA_WIDTH-1:0] zero_wire;
    assign zero_wire = 8'b0;

    weight_stationary_pe PE00 (
        .clk(clk),
        .reset(reset),
        .load_weight(load_weights),
        .valid(start),
        .input_in(x0),
        .weight(w00),
        .psum_in(zero_wire),
        .input_out(input_inter0),
        .psum_out(psum_inter0)
    );

    weight_stationary_pe PE01 (
        .clk(clk),
        .reset(reset),
        .load_weight(load_weights),
        .valid(start),
        .input_in(input_inter0),
        .weight(w01),
        .psum_in(zero_wire),
        .input_out(),
        .psum_out(psum_inter1)
    );

    weight_stationary_pe PE10 (
        .clk(clk),
        .reset(reset),
        .load_weight(load_weights),
        .valid(start),
        .input_in(x1),
        .weight(w10),
        .psum_in(psum_inter0),
        .input_out(input_inter1),
        .psum_out(y0)
    );

    weight_stationary_pe PE11 (
        .clk(clk),
        .reset(reset),
        .load_weight(load_weights),
        .valid(start),
        .input_in(input_inter1),
        .weight(w11),
        .psum_in(psum_inter1),
        .input_out(),
        .psum_out(y1)
    );

endmodule
