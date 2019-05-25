`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:00 12/04/2018 
// Design Name: 
// Module Name:    BE_EXT 
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
module BE_EXT(
    input [31:0] DMOut,
    input [1:0] Addr,
    input [5:0] Op,
    output [31:0] DMExt
    );

	parameter lb  = 6'b100000,
				 lbu = 6'b100100,
				 lh  = 6'b100001,
				 lhu = 6'b100101,
				 lw  = 6'b100011;
				 
	assign DMExt = ((Op == lb ) & (Addr == 2'b00)) ? {{24{DMOut[7]}},DMOut[7:0]} 		:
						((Op == lb ) & (Addr == 2'b01)) ? {{24{DMOut[15]}},DMOut[15:8]} 	:
						((Op == lb ) & (Addr == 2'b10)) ? {{24{DMOut[23]}},DMOut[23:16]} 	:
						((Op == lb ) & (Addr == 2'b11)) ? {{24{DMOut[31]}},DMOut[31:24]} 	:
						((Op == lbu) & (Addr == 2'b00)) ? {{24'b0},DMOut[7:0]} 				:
						((Op == lbu) & (Addr == 2'b01)) ? {{24'b0},DMOut[15:8]} 				:
						((Op == lbu) & (Addr == 2'b10)) ? {{24'b0},DMOut[23:16]}				:
						((Op == lbu) & (Addr == 2'b11)) ? {{24'b0},DMOut[31:24]} 			:
						((Op == lh ) & (Addr == 2'b00)) ? {{16{DMOut[15]}},DMOut[15:0]} 	:
						((Op == lh ) & (Addr == 2'b10)) ? {{16{DMOut[31]}},DMOut[31:16]}	:
						((Op == lhu) & (Addr == 2'b00)) ? {{16'b0},DMOut[15:0]} 				:
						((Op == lhu) & (Addr == 2'b10)) ? {{16'b0},DMOut[31:16]} 			:
																	 DMOut;
						
endmodule
