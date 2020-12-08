/////////////////////////////////////////////////////////////////////
////                                                             ////
////  rotating unit, stays between 2 stages of FFT pipeline      ////
////                                                             ////
////                                                             ////
////  Authors: Ahmed Abdelazeem                                  ////
////  Company: Zagazig University                                ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
// Design_Version       : 1.0
// File name            : 
// File Revision        : 
// Last modification    : Sun Dec 1 20:11:56 2020
/////////////////////////////////////////////////////////////////////
// FUNCTION: complex multiplication to the twiddle factors proper to the 64  point FFT
// PROPERTIES: 1) Has 64-clock cycle period starting with the START impulse and continuing forever
//	         2) rounding	is not used
/////////////////////////////////////////////////////////////////////

//`timescale 1ps / 1ps
`include "FFT64_CONFIG.inc"	 

module ROTATOR64 (CLK ,RST,ED,START, DR,DI, DOR, DOI,RDY  );
	`USFFT64paramnb	
	`USFFT64paramnw	
	
	input RST ;
	wire RST ;
	input CLK ;
	wire CLK ;
	input ED ; //operation enable
	input [nb+1:0] DI;  //Imaginary part of data
	wire [nb+1:0]  DI ;
	input [nb+1:0]  DR ; //Real part of data
	input START ;		   //1-st Data is entered after this impulse 
	wire START ;
	
	output [nb+1:0]  DOI ; //Imaginary part of data
	wire [nb+1:0]  DOI ;
	output [nb+1:0]  DOR ; //Real part of data
	wire [nb+1:0]  DOR ;
	output RDY ;	   //repeats START impulse following the output data
	reg RDY ;		 
	

	reg [5:0] addrw;
	reg sd1,sd2;
	always	@( posedge CLK)	  //address counter for twiddle factors
		begin
			if (RST) begin
					addrw<=0;
					sd1<=0;
					sd2<=0;
				end
			else if (START && ED)  begin
					addrw[5:0]<=0;
					sd1<=START;
					sd2<=0;		 
				end
			else if (ED) 	  begin
					addrw<=addrw+1; 
					sd1<=START;
					sd2<=sd1;
					RDY<=sd2;	 
				end
		end			  

		wire signed [nw-1:0] wr,wi; //twiddle factor coefficients
	//twiddle factor ROM
	WROM64 UROM( .ADDR(addrw),	.WR(wr),.WI(wi) );	
		
		
	reg signed [nb+1 : 0] drd,did;
	reg signed [nw-1 : 0] wrd,wid;
	wire signed [nw+nb+1 : 0] drri,drii,diri,diii;
	reg signed [nb+2:0] drr,dri,dir,dii,dwr,dwi;
	
	assign  	drri=drd*wrd;  
	assign	diri=did*wrd;  
	assign	drii=drd*wid;
	assign	diii=did*wid;  
	
	always @(posedge CLK)	 //complex multiplier	 
		begin
			if (ED) begin	
					drd<=DR;
					did<=DI;
					wrd<=wr;
					wid<=wi;
					drr<=drri[nw+nb+1 :nw-1]; //msbs of multiplications are stored
					dri<=drii[nw+nb+1 : nw-1];
					dir<=diri[nw+nb+1 : nw-1];
					dii<=diii[nw+nb+1 : nw-1];
					dwr<=drr - dii;				
					dwi<=dri + dir;  
				end	 
		end 		
	assign DOR=dwr[nb+2:1];       
	assign DOI=dwi[nb+2 :1];
	
endmodule
