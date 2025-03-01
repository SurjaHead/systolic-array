  module dump();
  initial begin
    $dumpfile("pe.vcd");
    $dumpvars(0, weight_stationary_pe); 
  end
  endmodule