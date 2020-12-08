/////////////////////////////////////////////////////////////////////
////                                                             ////
////  2-port RAM                                                 ////
////                                                             ////
////                                                             ////
////  Authors: Ahmed Abdelazeem                                  ////
////  Company: Zagazig University                                ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
// Design_Version       : 1.0
// File name            : RAM2x64C_1.v
// Last modification    : Sun Dec 1 20:11:56 2020
/////////////////////////////////////////////////////////////////////
// FUNCTION: 2-port RAM with 1 port to write and 1 port to read
// FILES: RAM2x64C_1.v - dual ported synchronous RAM, contains:		
//	    RAM64.v -single ported synchronous RAM
// PROPERTIES: 1)Has the volume of 2x64 complex data
//	         2)Contains 4 single port RAMs for real and 
//               imaginary parts of data in the 2-fold volume 
//		     Two halves of RAM are switched on and off in the 
//               write mode by the signal ODD	
//		   3)RAM is synchronous one, the read datum is 
//               outputted in 2 cycles after the address setting
//		   4)Can be substituted to any 2-port synchronous 
//		     RAM for example, to one RAMB16_S36_S36 in XilinxFPGAs	
/////////////////////////////////////////////////////////////////////

//`timescale 1 ns / 1 ps
`include "FFT64_CONFIG.inc"	 

module RAM2x64C_1 ( CLK ,ED ,WE ,ODD ,ADDRW ,ADDRR ,DR ,DI ,DOR ,DOI );
	`USFFT64paramnb	
	
	
	output [nb-1:0] DOR ;
	wire [nb-1:0] DOR ;
	output [nb-1:0] DOI ;
	wire [nb-1:0] DOI ;
	input CLK ;
	wire CLK ;
	input ED ;
	wire ED ;
	input WE ;	     //write enable
	wire WE ;
	input ODD ;	  // RAM part switshing
	wire ODD ;
	input [5:0] ADDRW ;
	wire [5:0] ADDRW ;
	input [5:0] ADDRR ;
	wire [5:0] ADDRR ;
	input [nb-1:0] DR ;
	wire [nb-1:0] DR ;
	input [nb-1:0] DI ;
	wire [nb-1:0] DI ;	
	
	reg	oddd,odd2;
	always @( posedge CLK) begin //switch which reswiches the RAM parts
			if (ED)	begin
					oddd<=ODD;
					odd2<=oddd;
				end
		end 
	`ifdef 	USFFT64bufferports1
	//One-port RAMs are used
	wire we0,we1;
	wire	[nb-1:0] dor0,dor1,doi0,doi1;
	wire	[5:0] addr0,addr1;		   
	
	
	
	assign	addr0 =ODD?  ADDRW: ADDRR;		//MUXA0
	assign	addr1 = ~ODD? ADDRW:ADDRR;	// MUXA1
	assign	we0   =ODD?  WE: 0;		     // MUXW0: 
	assign	we1   =~ODD? WE: 0;			 // MUXW1:
	
	//1-st half - write when odd=1	 read when odd=0
	RAM64 #(nb) URAM0(.CLK(CLK),.ED(ED),.WE(we0), .ADDR(addr0),.DI(DR),.DO(dor0)); // 
	RAM64 #(nb) URAM1(.CLK(CLK),.ED(ED),.WE(we0), .ADDR(addr0),.DI(DI),.DO(doi0));	 
	
	//2-d half
	RAM64 #(nb) URAM2(.CLK(CLK),.ED(ED),.WE(we1), .ADDR(addr1),.DI(DR),.DO(dor1));//	  
	RAM64 #(nb) URAM3(.CLK(CLK),.ED(ED),.WE(we1), .ADDR(addr1),.DI(DI),.DO(doi1));		
	
	assign	DOR=~odd2? dor0 : dor1;		 // MUXDR: 
	assign	DOI=~odd2? doi0 : doi1;	//  MUXDI:
	
	`else 		
	//Two-port RAM is used
	wire [6:0] addrr2 = {ODD,ADDRR};
	wire [6:0] addrw2 = {~ODD,ADDRW};
	wire [2*nb-1:0] di= {DR,DI} ;	
	wire [2*nb-1:0] doi;	
	
	reg [2*nb-1:0] ram [127:0];
	reg [6:0] read_addra;
	always @(posedge CLK) begin
			if (ED)
				begin
					if (WE)
						ram[addrw2] <= di;
					read_addra <= addrr2;
				end
		end
	assign doi = ram[read_addra];				 
	
	assign	DOR=doi[2*nb-1:nb];		 // Real read data 
	assign	DOI=doi[nb-1:0];		 // Imaginary read data
	
	
	`endif 	
endmodule
