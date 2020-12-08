/////////////////////////////////////////////////////////////////////
////                                                             ////
////  1-port synchronous RAM                                     ////
////                                                             ////
////                                                             ////
////  Authors: Ahmed Abdelazeem                                  ////
////  Company: Zagazig University                                ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
// Design_Version       : 1.0
// File name            : RAM64.v
// File Revision        : 
// Last modification    : Sun Dec 1 20:11:56 2020
/////////////////////////////////////////////////////////////////////
// FUNCTION: 1-port synchronous RAM
// FILES:    RAM64.v -single ported synchronous RAM
// PROPERTIES: 1) Has the volume of 64 data
//	         2) RAM is synchronous one, the read datum is outputted 
//                in 2 cycles after the address setting
//		   3) Can be substituted to any 2-port synchronous RAM 
/////////////////////////////////////////////////////////////////////

//`timescale 1 ns / 1 ps
`include "FFT64_CONFIG.inc"	 

module RAM64 ( CLK, ED,WE ,ADDR ,DI ,DO );
	`USFFT64paramnb	
	
	output [nb-1:0] DO ;
	reg [nb-1:0] DO ;
	input CLK ;
	wire CLK ;	 
	input ED;
	input WE ;
	wire WE ;
	input [5:0] ADDR ;
	wire [5:0] ADDR ;
	input [nb-1:0] DI ;
	wire [nb-1:0] DI ;
	reg [nb-1:0] mem [63:0];
	reg [5:0] addrrd;		  
	
	always @(posedge CLK) begin
			if (ED) begin
					if (WE)		mem[ADDR] <= DI;
					addrrd <= ADDR;	         //storing the address
					DO <= mem[addrrd];	   // registering the read datum
				end	  
		end
	
	
endmodule
