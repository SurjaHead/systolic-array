# Simulation parameters
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Use the correct file path and module name
VERILOG_SOURCES += $(PWD)/weight_stationary_pe.sv

# Enable SystemVerilog support for Icarus Verilog
IVERILOG_ARGS += -g2005-sv

test_pe:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s weight_stationary_pe -s dump -g2012 src/weight_stationary_pe.sv tests/dump_pe.sv
	PYTHONOPTIMIZE=${NOASSERT} MODULE=tests.test_pe vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

# Other targets
clean::
	rm -rf __pycache__
	rm -rf sim_build
	rm -f results.xml
	rm -f pe.vcd