`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:07:37 12/10/2018 
// Design Name: 
// Module Name:    Hazards 
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
`define rs 25:21
`define rt 20:16
module Hazards(
	 input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    input [31:0] IR_W,
	 input [4:0] A3_E,
	 input [4:0] A3_M,
	 input [4:0] A3_W,
	 input W_E,
	 input W_M,
	 input W_W,
	 input Stall_MDU,
	 output Stall,
    output [1:0] RSDsel,
    output [1:0] RTDsel,
    output [1:0] RSEsel,
    output [1:0] RTEsel,
	 output [1:0] RTMsel
    );
	
	wire Stall_RS0_EA,Stall_RS0_ED,Stall_RS0_MD,Stall_RS1_ED;
	wire Stall_RT0_EA,Stall_RT0_ED,Stall_RT0_MD,Stall_RT1_ED;

	wire [1:0] Tnew_E,Tnew_M,Tnew_W;
	wire [1:0] Tuse_RS,Tuse_RT;
	
	assign Stall_RS0_EA = (Tuse_RS == 0) & (Tnew_E == 1) & (IR_D[`rs] == A3_E) & (IR_D[`rs] != 0) & W_E;
	assign Stall_RS0_ED = (Tuse_RS == 0) & (Tnew_E == 2) & (IR_D[`rs] == A3_E) & (IR_D[`rs] != 0) & W_E;
	assign Stall_RS0_MD = (Tuse_RS == 0) & (Tnew_M == 1) & (IR_D[`rs] == A3_M) & (IR_D[`rs] != 0) & W_M;
	assign Stall_RS1_ED = (Tuse_RS == 1) & (Tnew_E == 2) & (IR_D[`rs] == A3_E) & (IR_D[`rs] != 0) & W_E;
	
	assign Stall_RT0_EA = (Tuse_RT == 0) & (Tnew_E == 1) & (IR_D[`rt] == A3_E) & (IR_D[`rt] != 0) & W_E;
	assign Stall_RT0_ED = (Tuse_RT == 0) & (Tnew_E == 2) & (IR_D[`rt] == A3_E) & (IR_D[`rt] != 0) & W_E;
	assign Stall_RT0_MD = (Tuse_RT == 0) & (Tnew_M == 1) & (IR_D[`rt] == A3_M) & (IR_D[`rt] != 0) & W_M;
	assign Stall_RT1_ED = (Tuse_RT == 1) & (Tnew_E == 2) & (IR_D[`rt] == A3_E) & (IR_D[`rt] != 0) & W_E;
	
	assign Stall = Stall_RS0_EA | Stall_RS0_ED | Stall_RS0_MD | Stall_RS1_ED |
						Stall_RT0_EA | Stall_RT0_ED | Stall_RT0_MD | Stall_RT1_ED |
						Stall_MDU;

	assign RSDsel = ( (IR_D[`rs]==A3_M) & (IR_D[`rs]!=0) & (Tnew_M==0) & W_M ) ? 2 :
						 ( (IR_D[`rs]==A3_W) & (IR_D[`rs]!=0) 				  	 & W_W ) ? 1 :
																										  0;
																						  
   assign RTDsel = ( (IR_D[`rt]==A3_M) & (IR_D[`rt]!=0) & (Tnew_M==0) & W_M ) ? 2 :
						 ( (IR_D[`rt]==A3_W) & (IR_D[`rt]!=0) 					 & W_W ) ? 1 :
																										  0;
																			 
   assign RSEsel = ( (IR_E[`rs]==A3_M) & (IR_E[`rs]!=0) & (Tnew_M==0) & W_M ) ? 2 :
						 ( (IR_E[`rs]==A3_W) & (IR_E[`rs]!=0) 				  	 & W_W ) ? 1 :
																										  0;
																			 
   assign RTEsel = ( (IR_E[`rt]==A3_M) & (IR_E[`rt]!=0) & (Tnew_M==0) & W_M ) ? 2 :
						 ( (IR_E[`rt]==A3_W) & (IR_E[`rt]!=0) 				    & W_W ) ? 1 :
																										  0;
																			 
	assign RTMsel = ( (IR_M[`rt]==A3_W) & (IR_M[`rt]!=0) & W_W ) ? 1 : 0;
	
	ControlHazards T_USE (
    .IR(IR_D), 
    .Tuse_rs(Tuse_RS), 
    .Tuse_rt(Tuse_RT)
    );
	 
	ControlHazards T_E (
    .IR(IR_E), 
    .TnewSrc(2'b00), 
    .Tnew(Tnew_E)
    );
	 
	ControlHazards T_M (
    .IR(IR_M), 
    .TnewSrc(2'b01), 
    .Tnew(Tnew_M)
    );
	
	ControlHazards T_W (
    .IR(IR_W), 
    .TnewSrc(2'b10), 
    .Tnew(Tnew_W)
    );



endmodule
