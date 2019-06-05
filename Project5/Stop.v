`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:34:34 11/28/2018 
// Design Name: 
// Module Name:    Stop 
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
module Stop(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    output Stop
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
				 
	wire b_D, jr_D, cal_r_D, cal_i_D, load_D, store_D;
	wire cal_r_E, cal_i_E, load_E, store_E;
	wire load_M;
	
	wire [4:0] RS_D,RT_D;
	wire [4:0] RS_E,RT_E,RD_E;
	wire [4:0] RS_M,RT_M,RD_M;
	
	wire stall_b_r, stall_b_i, stall_b_load, stall_b_loadM;
	wire stall_cal_r_load;
	wire stall_cal_i_load;
	wire stall_load_load;
	wire stall_store_load;
	wire stall_jr_r, stall_jr_i, stall_jr_load, stall_jr_loadM;
	
	assign {RS_D, RT_D} 		  = {IR_D[`rs], IR_D[`rt]};
	assign {RS_E, RT_E, RD_E} = {IR_E[`rs], IR_E[`rt], IR_E[`rd]};
	assign {RS_M, RT_M, RD_M} = {IR_M[`rs], IR_M[`rt], IR_M[`rd]};
	
	assign b_D 		= (IR_D[`opcode] == beq);
	assign jr_D 	= (IR_D[`opcode] == R)   & (IR_D[`func] 	== jr_f);
	assign cal_r_D = (IR_D[`opcode] == R) 	 & (IR_D[`func] 	!= jr_f);
	assign cal_i_D = (IR_D[`opcode] == ori) | (IR_D[`opcode] == lui);
	assign load_D	= (IR_D[`opcode] == lw);
	assign store_D = (IR_D[`opcode] == sw);
	
	assign cal_r_E = (IR_E[`opcode] == R) 	 & (IR_E[`func] 	!= jr_f);
	assign cal_i_E = (IR_E[`opcode] == ori) | (IR_E[`opcode] == lui);
	assign load_E	= (IR_E[`opcode] == lw);
	assign store_E = (IR_E[`opcode] == sw);
	
	assign load_M	= (IR_M[`opcode] == lw);
	
	assign stall_b_r			= b_D 	 & cal_r_E & ( (RS_D == RD_E) | (RT_D == RD_E) );
	assign stall_b_i 			= b_D 	 & cal_i_E & ( (RS_D == RT_E) | (RT_D == RT_E) );
	assign stall_b_load 		= b_D     & load_E  & ( (RS_D == RT_E) | (RT_D == RT_E) );
	assign stall_b_loadM 	= b_D 	 & load_M  & ( (RS_D == RT_M) | (RT_D == RT_M) );
	
	assign stall_cal_r_load = cal_r_D & load_E  & ( (RS_D == RT_E) | (RT_D == RT_E) );
	
	assign stall_cal_i_load = cal_i_D & load_E  &   (RS_D == RT_E);
	
	assign stall_load_load 	= load_D  & load_E  &   (RS_D == RT_E);
	
	assign stall_store_load = store_D & load_E  &   (RS_D == RT_E);

	assign stall_jr_r			= jr_D	 & cal_r_E &   (RS_D == RD_E);
	assign stall_jr_i			= jr_D	 & cal_i_E &   (RS_D == RT_E);
	assign stall_jr_load		= jr_D	 & load_E  &   (RS_D == RT_E);
	assign stall_jr_loadM	= jr_D	 & load_M  &   (RS_D == RT_M);

	assign Stop = stall_b_r | stall_b_i | stall_b_load | stall_b_loadM |
					  stall_cal_r_load | stall_cal_i_load |
					  stall_load_load | stall_store_load |
					  stall_jr_r | stall_jr_i | stall_jr_load | stall_jr_loadM;
	
endmodule
