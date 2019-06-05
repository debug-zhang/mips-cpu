`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:48 11/28/2018 
// Design Name: 
// Module Name:    Forward 
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
`define opcode 31:26
`define func 5:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
module Forward(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    input [31:0] IR_W,
    output [2:0] RSDsel,
    output [2:0] RTDsel,
    output [2:0] RSEsel,
    output [2:0] RTEsel,
	 output [2:0] RTMsel
    );

	parameter R		  = 6'b000000,
				 addu_f = 6'b100001,
				 subu_f = 6'b100011,
				 jr_f   = 6'b001000,
				 ori    = 6'b001101,
				 lw     = 6'b100011,
				 sw     = 6'b101011,
				 beq    = 6'b000100,
				 lui    = 6'b001111,
				 j		  = 6'b000010,
				 jal    = 6'b000011;

	wire b_D, jr_D;
	wire cal_r_E, cal_i_E, jal_E,load_E, store_E;
	wire cal_r_M, cal_i_M, jal_M,load_M, store_M;
	wire cal_r_W, cal_i_W, jal_W,load_W, store_W;
	
	wire [4:0] RS_D,RT_D;
	wire [4:0] RS_E,RT_E,RD_E;
	wire [4:0] RS_M,RT_M,RD_M;
	wire [4:0] RS_W,RT_W,RD_W;
	
	assign {RS_D, RT_D} 		  = {IR_D[`rs], IR_D[`rt]};
	assign {RS_E, RT_E, RD_E} = {IR_E[`rs], IR_E[`rt], IR_E[`rd]};
	assign {RS_M, RT_M, RD_M} = {IR_M[`rs], IR_M[`rt], IR_M[`rd]};
	assign {RS_W, RT_W, RD_W} = {IR_W[`rs], IR_W[`rt], IR_W[`rd]};
	
	assign b_D 		= (IR_D[`opcode] == beq);
	assign jr_D 	= (IR_D[`opcode] == R)   & (IR_D[`func] 	== jr_f);
	
	assign cal_r_E = (IR_E[`opcode] == R) 	 & (IR_E[`func] 	!= jr_f);
	assign cal_i_E = (IR_E[`opcode] == ori) | (IR_E[`opcode] == lui);
	assign jal_E	= (IR_E[`opcode] == jal);
	assign load_E	= (IR_E[`opcode] == lw);
	assign store_E = (IR_E[`opcode] == sw);
	
	assign cal_r_M = (IR_M[`opcode] == R) 	 & (IR_M[`func] 	!= jr_f);
	assign cal_i_M = (IR_M[`opcode] == ori) | (IR_M[`opcode] == lui);
	assign jal_M	= (IR_M[`opcode] == jal);
	assign load_M	= (IR_M[`opcode] == lw);
	assign store_M = (IR_M[`opcode] == sw);
	
	assign cal_r_W = (IR_W[`opcode] == R) 	 & (IR_W[`func] 	!= jr_f);
	assign cal_i_W = (IR_W[`opcode] == ori) | (IR_W[`opcode] == lui);
	assign jal_W	= (IR_W[`opcode] == jal);
	assign load_W	= (IR_W[`opcode] == lw);
	assign store_W = (IR_W[`opcode] == sw);
	
	
	assign RSDsel = ( (b_D | jr_D) & jal_E   & (RS_D == 31) )					  ? 4 :
						 ( (b_D | jr_D) & cal_r_M & (RS_D == RD_M) & (RS_D != 0) ) ? 3 :
						 ( (b_D | jr_D) & cal_i_M & (RS_D == RT_M) & (RS_D != 0) ) ? 3 :
						 ( (b_D | jr_D) & jal_M   & (RS_D == 31) )					  ? 2 :
						 ( (b_D | jr_D) & cal_r_W & (RS_D == RD_W) & (RS_D != 0) ) ? 1 :
						 ( (b_D | jr_D) & cal_i_W & (RS_D == RT_W) & (RS_D != 0) ) ? 1 :
						 ( (b_D | jr_D) & load_W  & (RS_D == RT_W) & (RS_D != 0) ) ? 1 :
						 ( (b_D | jr_D) & jal_W   & (RS_D == 31) )					  ? 1 :
																									    0;
																						  
   assign RTDsel = ( b_D & jal_E   & (RT_D == 31) )					  ? 4 :
						 ( b_D & cal_r_M & (RT_D == RD_M) & (RT_D != 0) ) ? 3 :
						 ( b_D & cal_i_M & (RT_D == RT_M) & (RT_D != 0) ) ? 3 :
						 ( b_D & jal_M   & (RT_D == 31) )					  ? 2 :
						 ( b_D & cal_r_W & (RT_D == RD_W) & (RT_D != 0) ) ? 1 :
						 ( b_D & cal_i_W & (RT_D == RT_W) & (RT_D != 0) ) ? 1 :
						 ( b_D & load_W  & (RT_D == RT_W) & (RT_D != 0) ) ? 1 :
						 ( b_D & jal_W   & (RT_D == 31) )					  ? 1 :
																							 0;
																			 
   assign RSEsel = ( (cal_r_E | cal_i_E | load_E | store_E) & cal_r_M & (RS_E == RD_M) & (RS_E != 0) ) ? 3 :
						 ( (cal_r_E | cal_i_E | load_E | store_E) & cal_i_M & (RS_E == RT_M) & (RS_E != 0) ) ? 3 :
						 ( (cal_r_E | cal_i_E | load_E | store_E) & jal_M   & (RS_E == 31) )					    ? 2 :
						 ( (cal_r_E | cal_i_E | load_E | store_E) & cal_r_W & (RS_E == RD_W) & (RS_E != 0) ) ? 1 :
						 ( (cal_r_E | cal_i_E | load_E | store_E) & cal_i_W & (RS_E == RT_W) & (RS_E != 0) ) ? 1 :
						 ( (cal_r_E | cal_i_E | load_E | store_E) & load_W  & (RS_E == RT_W) & (RS_E != 0) ) ? 1 :
						 ( (cal_r_E | cal_i_E | load_E | store_E) & jal_W   & (RS_E == 31) )					    ? 1 :
																																		   0;
			
   assign RTEsel = ( (cal_r_E | store_E) & cal_r_M & (RT_E == RD_M) & (RT_E != 0) ) ? 3 :
						 ( (cal_r_E | store_E) & cal_i_M & (RT_E == RT_M) & (RT_E != 0) ) ? 3 :
						 ( (cal_r_E | store_E) & jal_M   & (RT_E == 31) )					   ? 2 :
						 ( (cal_r_E | store_E) & cal_r_W & (RT_E == RD_W) & (RT_E != 0) ) ? 1 :
						 ( (cal_r_E | store_E) & cal_i_W & (RT_E == RT_W) & (RT_E != 0) ) ? 1 :
						 ( (cal_r_E | store_E) & load_W  & (RT_E == RT_W) & (RT_E != 0) ) ? 1 :
						 ( (cal_r_E | store_E) & jal_W   & (RT_E == 31) )					   ? 1 :
																												  0;
	assign RTMsel = ( store_M & cal_r_W & (RT_M == RD_W) & (RT_M != 0) ) ? 1 :
						 ( store_M & cal_i_W & (RT_M == RT_W) & (RT_M != 0) ) ? 1 :
						 ( store_M & load_W  & (RT_M == RT_W) & (RT_M != 0) ) ? 1 :
						 ( store_M & jal_W   & (RT_M == 31) )					   ? 1 :
																								  0;
	
endmodule
