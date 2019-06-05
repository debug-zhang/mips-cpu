`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:47:24 11/20/2018 
// Design Name: 
// Module Name:    nPC 
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
module NPC(
    input [25:0] Instr,
	 input [31:0] PC_F,
	 input [31:0] PC_D,
    input [31:0] rs,
	 input [31:0] A,
	 input [31:0] B,
    input [3:0] NPCOp,
    output [31:0] npc
    );

	wire [15:0] offset;
	wire [31:0] PC_F4;
	wire [31:0] PC_D4;
	parameter	OTHER = 4'b0000,
					BEQ	= 4'b0001,
					BGEZ 	= 4'b0010,
					BGTZ 	= 4'b0011,
					BLEZ	= 4'b0100,
					BLTZ	= 4'b0101,
					BNE	= 4'b0110,
					J_JAL	= 4'b0111,
					JALR_JR=4'b1000;
	
	assign offset = Instr[15:0];
	
	assign PC_F4 = PC_F + 4;
	assign PC_D4 = PC_D + 4;
	
	assign npc =  (NPCOp == OTHER) 							? PC_F4 :
					 ((NPCOp == BEQ)  & (A == B)) 			? PC_D4 + {{14{offset[15]}},offset,2'b00} :
					 ((NPCOp == BGEZ) & ($signed(A) >= 0)) ? PC_D4 + {{14{offset[15]}},offset,2'b00} :
					 ((NPCOp == BGTZ) & ($signed(A) >  0)) ? PC_D4 + {{14{offset[15]}},offset,2'b00} :
					 ((NPCOp == BLEZ) & ($signed(A) <= 0)) ? PC_D4 + {{14{offset[15]}},offset,2'b00} :
					 ((NPCOp == BLTZ) & ($signed(A) <  0)) ? PC_D4 + {{14{offset[15]}},offset,2'b00} :
					 ((NPCOp == BNE)  & (A != B)) 			? PC_D4 + {{14{offset[15]}},offset,2'b00} :
					  (NPCOp == J_JAL) 							? {PC_D[31:28],Instr,2'b00} : 
					  (NPCOp == JALR_JR)							? rs :
																		  PC_D4 + 4;
																  
endmodule
