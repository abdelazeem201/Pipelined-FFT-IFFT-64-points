/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Multiplier by 0.7071                                       ////
////                                                             ////
////                                                             ////
////  Authors: Ahmed Abdelazeem                                  ////
////  Company: Zagazig University                                ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
// Design_Version       : 1.0
// File name            : MPU707.v
// File Revision        : 
// Last modification    : Sun Dec 1 20:11:56 2020
/////////////////////////////////////////////////////////////////////
// FUNCTION: Constant multiplier
// PROPERTIES:1)Is based on shifts right and add
//		  2)for short input bit width 0.7071 is approximated as
//              10110101 then rounding is not used
//		  3)for long input bit width 0.7071 is approximated as 
//              10110101000000101	       
//		  4)hardware is 3 or 4 adders 
/////////////////////////////////////////////////////////////////////
`include "FFT64_CONFIG.inc"

module MPU707 ( CLK ,DO ,DI ,EI );
`USFFT64paramnb 
	
	input CLK ;
	wire CLK ;
	input [nb+1:0] DI ;
	wire signed [nb+1:0] DI ;
	input EI ;
	wire EI ;
	
	output [nb+1:0] DO ;
	reg [nb+1:0] DO ;	 
	
	reg signed [nb+5 :0] dx5;	 
	reg signed	[nb+2 : 0] dt;		   
	wire signed [nb+6 : 0]  dx5p; 
	wire  signed  [nb+6 : 0] dot;	
	
	always @(posedge CLK)
		begin
			if (EI) begin
					dx5<=DI+(DI <<2);	 //multiply by 5
					dt<=DI;		  
					DO<=dot >>>4;	
				end 
		end		 
		
	`ifdef USFFT64bitwidth_0707_high
	assign   dot=	(dx5p+(dt>>>4)+(dx5>>>12));	   // multiply by 10110101000000101	      
	`else	                               
	assign    dot=		(dx5p+(dt>>>4) )	;  // multiply by 10110101	   
	`endif	 	
		
		assign	dx5p=(dx5<<1)+(dx5>>>2);		// multiply by 101101		 	
	
	
endmodule
