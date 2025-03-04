
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





// `default_nettype none
// `timescale 1ns/1ns

// module processing_element (
//   input wire clk,
//   input wire reset,
//   input wire load_weight,       // Signal to load weight
//   input wire valid,             // Valid signal indicating new data is available

//   input wire [7:0] a_in,       // Input A from left neighbor
//   input wire [7:0] weight,     // Weight input
//   input wire [7:0] acc_in,     // Accumulated value from the PE above

//   output reg [7:0] a_out,    // Output A to right neighbor
//   output reg [7:0] acc_out   // Accumulated value to the PE below
// );

//   reg [7:0] weight_reg; // Register to hold the stationary weight

//   always @(posedge clk or posedge reset) begin
//     if (reset) begin
      
//       a_out <= 8'b0;
//       acc_out <= 8'b0;
//       weight_reg <= 8'b0;

//     end else begin

//       if (load_weight) begin
//         weight_reg <= weight;
//       end 

//       if (valid) begin // means compute!
//         acc_out <= acc_in + (a_in * weight_reg);
//         a_out <= a_in;
//       end

//     end
//   end
// endmodule