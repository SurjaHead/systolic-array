import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer

@cocotb.test()
async def test_processing_element(dut):
    """Test the processing_element module."""

    # Create a clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    await Timer(10, units="ns")

    # Reset the DUT (device under test)
    dut.reset.value = 1
    dut.load_weight.value = 0
    dut.valid.value = 0
    dut.input_in.value = 0
    dut.weight.value = 0
    dut.psum_in.value = 0

    # deactivate reset to allow other functionality
    await Timer(10, units="ns")
    dut.reset.value = 0

    # load weight on to the PE
    dut.load_weight.value = 1
    dut.weight.value = 10
    await Timer(10, units="ns")
    dut.load_weight.value = 0

    # set input_in and psum_in to arbitrary values  
    dut.input_in.value = 5
    dut.psum_in.value = 2
    dut.valid.value = 1

    await Timer(10, units="ns")

    # deactivate the valid signal to stop loading new data
    dut.valid.value = 0
    await Timer(10, units="ns")

    # set input_in and psum_in to different values 
    dut.input_in.value = 3
    dut.psum_in.value = 4
    dut.valid.value = 1

    await Timer(10, units="ns")
    # Deactivate the valid signal
    dut.valid.value = 0
    await Timer(10, units="ns")
