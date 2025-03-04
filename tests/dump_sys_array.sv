  module dump();
  initial begin
    $dumpfile("sys_array.vcd");
    $dumpvars(0, systolic_array); 
  end
  endmodule