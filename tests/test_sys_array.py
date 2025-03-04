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
    dut.reset.value = 1
    dut.load_weights.value = 0
    dut.w00.value = 0
    dut.w01.value = 0
    dut.w10.value = 0
    dut.w11.value = 0
    dut.x0.value = 0
    dut.x1.value = 0
    dut.y0.value = 0
    dut.y1.value = 0
    dut.start.value = 0
    dut.done.value = 0

    await Timer(10, units="ns")

    dut.reset.value = 0

    await Timer(10, units="ns")

    dut.load_weights.value = 1
    dut.w00.value = 1
    dut.w01.value = 2
    dut.w10.value = 3
    dut.w11.value = 4
    
    await Timer(10, units="ns")

    dut.start.value = 1

    await Timer(10, units="ns")
    dut.x0.value = 5
    dut.x1.value = 0

    await Timer(10, units="ns")
    dut.x0.value = 6
    dut.x1.value = 7

    await Timer(10, units="ns")
    dut.x0.value = 0
    dut.x1.value = 8

    await Timer(10, units="ns")

    dut.x0.value = 0
    dut.x1.value = 0

    await Timer(10, units="ns")

    dut.x0.value = 0
    dut.x1.value = 0
    dut.done.value = 1

    await Timer(10, units="ns")



# import cocotb
# from cocotb.clock import Clock
# from cocotb.triggers import RisingEdge, ClockCycles

# #VERIFIED FUNCIONALITY ✅

# @cocotb.test()
# async def test_mmu(dut):
#     cocotb.start_soon(Clock(dut.clk, 10, units="us").start())

#     dut.reset.value = 1
#     await ClockCycles(dut.clk, 1)
#     dut.reset.value = 0
#     await ClockCycles(dut.clk, 1)
#     dut.load_weight.value = 1
#     dut.weight1.value = 3
#     dut.weight2.value = 4
#     dut.weight3.value = 5
#     dut.weight4.value = 6
#     await ClockCycles(dut.clk, 1)
#     dut.valid.value = 1

#     await ClockCycles(dut.clk, 1)

#     dut.a_in1.value = 11
#     dut.a_in2.value = 0
#     await ClockCycles(dut.clk, 1)

#     dut.a_in1.value = 12
#     dut.a_in2.value = 21
#     await ClockCycles(dut.clk, 1)

#     dut.a_in1.value = 0
#     dut.a_in2.value = 22
#     await ClockCycles(dut.clk, 1)
    
#     dut.a_in1.value = 0
#     dut.a_in2.value = 0
#     await ClockCycles(dut.clk, 1)

#     dut.a_in1.value = 0
#     dut.a_in2.value = 0
#     await ClockCycles(dut.clk, 1)
#     await ClockCycles(dut.clk, 1)
#     await ClockCycles(dut.clk, 1)
#     await ClockCycles(dut.clk, 1)
    





    



