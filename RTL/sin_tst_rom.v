/////////////////////////////////////////////////////////////////////
////                                                             ////
////  ROM with 64 samples of sine waves at the frequencies 0/1   ////
////                                                             ////
////  Authors: Ahmed Abdelazeem,                                 ////
////  Company: Zagazig University                                ////
////                                                             ////
////                                                             ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//`timescale 1 ns / 1 ps  
module Wave_ROM64 ( ADDR ,DATA ); 
    	output [15:0] DATA ;     
    	input [5:0]    ADDR ;     
    	reg [15:0] sine[0:63];    
    	initial	  begin    
  sine[0]=16'h0000;  sine[1]=16'h0C8B;  sine[2]=16'h18F8;  sine[3]=16'h2527;
  sine[4]=16'h30FB;  sine[5]=16'h3C56;  sine[6]=16'h471C;  sine[7]=16'h5133;
  sine[8]=16'h5A82;  sine[9]=16'h62F1;  sine[10]=16'h6A6D;  sine[11]=16'h70E2;
  sine[12]=16'h7641;  sine[13]=16'h7A7C;  sine[14]=16'h7D8A;  sine[15]=16'h7F62;
  sine[16]=16'h7FFF;  sine[17]=16'h7F62;  sine[18]=16'h7D8A;  sine[19]=16'h7A7C;
  sine[20]=16'h7641;  sine[21]=16'h70E2;  sine[22]=16'h6A6D;  sine[23]=16'h62F1;
  sine[24]=16'h5A82;  sine[25]=16'h5133;  sine[26]=16'h471C;  sine[27]=16'h3C56;
  sine[28]=16'h30FB;  sine[29]=16'h2527;  sine[30]=16'h18F8;  sine[31]=16'h0C8B;
  sine[32]=16'h0000;  sine[33]=16'hF375;  sine[34]=16'hE708;  sine[35]=16'hDAD9;
  sine[36]=16'hCF05;  sine[37]=16'hC3AA;  sine[38]=16'hB8E4;  sine[39]=16'hAECD;
  sine[40]=16'hA57E;  sine[41]=16'h9D0F;  sine[42]=16'h9593;  sine[43]=16'h8F1E;
  sine[44]=16'h89BF;  sine[45]=16'h8584;  sine[46]=16'h8276;  sine[47]=16'h809E;
  sine[48]=16'h8001;  sine[49]=16'h809E;  sine[50]=16'h8276;  sine[51]=16'h8584;
  sine[52]=16'h89BF;  sine[53]=16'h8F1E;  sine[54]=16'h9593;  sine[55]=16'h9D0F;
  sine[56]=16'hA57E;  sine[57]=16'hAECD;  sine[58]=16'hB8E4;  sine[59]=16'hC3AA;
  sine[60]=16'hCF05;  sine[61]=16'hDAD9;  sine[62]=16'hE708;  sine[63]=16'hF375;
end 

	assign DATA=sine[ADDR];	
endmodule   
