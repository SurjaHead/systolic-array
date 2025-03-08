
`default_nettype none
`timescale 1ns/1ns

module weight_stationary_pe #(
  parameter DATA_WIDTH=8 // Bit width of weights and activations
)
(
  input wire clk,
  input wire reset,
  input wire load_weight,       // load the weight into the PE if this signal is high
  input wire valid,             // signal to indicate that new data is available

  input wire [DATA_WIDTH-1:0] input_in,       // input from the left adjacent PE or weight memory
  input wire [DATA_WIDTH-1:0] weight,     // weight stored in the PE
  input wire [DATA_WIDTH-1:0] psum_in,     // accumulated value from the PE above

  output reg [DATA_WIDTH-1:0] input_out,    // input to the right adjacent PE
  output reg [DATA_WIDTH-1:0] psum_out   // output value feeding into the PE below
);
    
  reg [DATA_WIDTH-1:0] weight_reg; // register used to store the weight when load_weight is high

  always @(posedge clk or posedge reset) begin
    if (reset) begin 
      // setting everything to 0 when the reset signal is high
      input_out <= 0;
      psum_out <= 0;
      weight_reg <= 0;

    end else begin

      if (load_weight) begin
        weight_reg <= weight; // load the weight into the PE
      end 

      // if (valid) begin
        psum_out <= psum_in + (input_in * weight_reg); // compute the new accumulated value
        input_out <= input_in; // pass the input to the right adjacent PE
      // end 

    end
  end
endmodule