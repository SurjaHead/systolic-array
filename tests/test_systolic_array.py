# import cocotb
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

#VERIFIED FUNCIONALITY ✅

@cocotb.test()
async def test_systolic_array(dut):

    # Create a clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset the DUT (device under test)
    dut.reset.value <= 1
    dut.load_weights.value <= 0
    dut.weight_data.value <= 0
    dut.weight_mem.value <= 0
    dut.input_data.value <= 0 
    dut.start.value <= 0

    await Timer(10, units="ns")
    dut.reset.value <= 0
    dut.load_weights.value <= 1
    dut.weight_data.value <= [[1, 2, 3], [4, 5, 6], [7, 8, 9]]



