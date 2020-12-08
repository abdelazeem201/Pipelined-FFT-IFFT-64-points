# Pipelined-FFT-IFFT-64-points
The USFFT64 User Manual contains description of the USFFT64 core architecture to explain its proper use. USFFT64 soft core is the unit to perform the Fast Fourier Transform (FFT). It performs one dimensional 64 – complex point FFT. The data and coefficient widths are adjustable in the range 8 to 16.

## Features

 64 -point radix-8 FFT.

 Forward and inverse FFT.

 Pipelined mode operation, each result is outputted in one clock cycle, the latent delay from input to output is equal to 163 clock cycles, 
simultaneous loading/downloading supported.

 Input data, output data, and coefficient widths are parametrizable in range 8 to 16.

 Two and three data buffers are selected.

 Overflow detectors of intermediate and resulting data are present.

 Two normalizing shifter stages provide the optimum data magnitude bandwidth.

 Structure can be configured in Xilinx, Altera, Actel, Lattice FPGA devices, and ASIC.

 Can be used in OFDM modems, software defined radio, multichannel coding

