/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Normalization unit                                         ////
////                                                             ////
////                                                             ////
////  Authors: Ahmed Abdelazeem                                  ////
////  Company: Zagazig University                                ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
// Design_Version       : 1.0
// File name            : CNORM.v
// File Revision        : 
// Last modification    : Sun Dec 1 20:11:56 2020
/////////////////////////////////////////////////////////////////////
// FUNCTION: shifting left up to 3 bits
// PROPERTIES:  1)shifting left up to 3 bits controlled by 
//                the 2-bit code SHIFT
//		    2)Is registered
//		    3)Overflow detector detects the overflow event 
//                by the given shift condition. The detector is 
//                zeroed by the START signal
//              4)RDY is the START signal delayed to a single 
//                clock cycle
/////////////////////////////////////////////////////////////////////
//`timescale 1 ns / 1 ps		 
`include "FFT64_CONFIG.inc"	 

module CNORM ( CLK ,ED ,START ,DR ,DI ,SHIFT ,OVF ,RDY ,DOR ,DOI );
	`USFFT64paramnb	
	
	output OVF ;
	reg OVF ;
	output RDY ;
	reg RDY ;
	output [nb+1:0] DOR ;
	wire [nb+1:0] DOR ;
	output [nb+1:0] DOI ;
	wire [nb+1:0] DOI ;
	
	input CLK ;
	wire CLK ;
	input ED ;
	wire ED ;
	input START ;
	wire START ;
	input [nb+2:0] DR ;
	wire [nb+2:0] DR ;
	input [nb+2:0] DI ;
	wire [nb+2:0] DI ;
	input [1:0] SHIFT ;
	wire [1:0] SHIFT ;
	
wire[nb+2:0]	 diri,diii;
assign diri = DR << SHIFT;
assign diii = DI << SHIFT;	 

reg [nb+2:0]	dir,dii;
    always @( posedge CLK )    begin
			if (ED)	  begin
					dir<=diri[nb+2:1];
     				dii<=diii[nb+2:1];
		end 
	end  

	
 always @( posedge CLK ) 	begin
		  	if (ED)	  begin
				RDY<=START;
				if (START) 
					OVF<=0;
				else   
					case (SHIFT) 
					2'b01 : OVF<= (DR[nb+2] != DR[nb+1]) || (DI[nb+2] != DI[nb+1]);
					2'b10 : OVF<= (DR[nb+2] != DR[nb+1]) || (DI[nb+2] != DI[nb+1]) ||
						(DR[nb+2] != DR[nb]) || (DI[nb+2] != DI[nb]);
					2'b11 : OVF<= (DR[nb+2] != DR[nb+1]) || (DI[nb+2] != DI[nb+1])||
						(DR[nb+2] != DR[nb]) || (DI[nb+2] != DI[nb]) ||
						(DR[nb+2] != DR[nb+1]) || (DI[nb-1] != DI[nb-1]);
					endcase						
				end
			end 
			
	assign DOR= dir;
	assign DOI= dii;
	
endmodule
