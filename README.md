# 2×2 Systolic Array Implementation

## Project Overview

This repository contains a Verilog implementation of a minimal 2×2 systolic array for matrix multiplication. The systolic array architecture provides an efficient hardware solution for performing parallel computations with high throughput and reduced memory access.

## Architecture

The 2×2 systolic array consists of:

- 4 Processing Elements (PEs) arranged in a 2×2 grid
- Each PE performs multiply-accumulate operations
- Horizontal data flow for input matrix A elements
- Vertical data flow for input matrix B elements
- Stationary result accumulation within each PE

```
     B0      B1
     ↓       ↓
A0→ [PE00]→[PE01]
     ↓       ↓
A1→ [PE10]→[PE11]
     ↓       ↓
    C00     C11
```

## Files

- `systolic_array_2x2.v` - Top module implementing the complete 2×2 systolic array
- `processing_element.v` - Single PE module implementing the multiply-accumulate operation
- `control_unit.v` - Control logic for managing data flow and timing
- `testbench.v` - Testbench for verification

## Usage

To use this systolic array:

1. Provide input matrices A and B in the appropriate skewed format
2. Control signals:
   - `clk`: System clock
   - `reset`: Active high reset signal
   - `start`: Signal to begin computation
   - `done`: Output signal indicating computation completion

## Input Format

Inputs are provided in a skewed fashion to maintain proper data flow:

```
Clock Cycle | A0 Input | A1 Input | B0 Input | B1 Input
------------|----------|----------|----------|----------
1           | A[0][0]  | -        | B[0][0]  | -
2           | A[0][1]  | A[1][0]  | B[1][0]  | B[0][1]
3           | -        | A[1][1]  | -        | B[1][1]
```

## Output Format

After computation completes, the result matrix C can be read from the PEs:

- C[0][0] from PE00
- C[0][1] from PE01
- C[1][0] from PE10
- C[1][1] from PE11

## Performance

- Latency: 5 clock cycles (for 2×2 matrices)
- Throughput: One matrix multiplication every 3 cycles (with proper pipelining)

## Future Improvements

- Scalable design to support larger matrix dimensions
- Enhanced control logic for handling various matrix sizes
- Memory interfaces for direct loading of matrix data
- Optimization for FPGA implementation
