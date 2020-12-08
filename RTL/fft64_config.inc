/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Parameter file                                             ////
////                                                             ////
////  Authors: Ahmed Abdelazeem                                  ////
////  Company: Zagazig University                                ////
////                                                             ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
// Design_Version       : 1.0
// File name            : fft64_config.inc
// File Revision        : 
// Last modification    : Sun Dec 1 20:11:56 2020
/////////////////////////////////////////////////////////////////////
	
`timescale 10 ps / 1ps

//input data bit width
`define USFFT64paramnb parameter nb=16;

//2-nd stage data bit width
`define USFFT64paramnb2 parameter nb2=nb+2;

//twiddle factor bit width
`define USFFT64paramnw parameter nw=15;

//when is absent then FFT, when is present then IFFT 
//`define USFFT64paramifft ;	

//buffer number 2 or 3
`define USFFT64parambuffers3	

// buffer type: 1 ports in RAMS else -2 ports RAMS
//`define USFFT64bufferports1

//Coeficient 0.707 bit width is increased
`define USFFT64bitwidth_0707_high