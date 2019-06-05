`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:55:03 12/04/2018 
// Design Name: 
// Module Name:    BE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BE(
    input [5:0] Op,
    input [1:0] Addr,
    output [3:0] BEOp
    );

	parameter sb = 6'b101000,
				 sh = 6'b101001,
				 sw = 6'b101011;
				 
	assign BEOp = ((Op == sb) & (Addr == 2'b00)) 	? 4'b0001 :
					  ((Op == sb) & (Addr == 2'b01)) 	? 4'b0010 :
					  ((Op == sb) & (Addr == 2'b10)) 	? 4'b0100 :
					  ((Op == sb) & (Addr == 2'b11)) 	? 4'b1000 :
					  ((Op == sh) & (Addr[1] == 1'b0)) 	? 4'b0011 :
					  ((Op == sh) & (Addr[1] == 1'b1)) 	? 4'b1100 :
																	  4'b1111;
endmodule
