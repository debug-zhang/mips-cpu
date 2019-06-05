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
    input [2:0] NPCOp,
    output [31:0] npc
    );

	wire [15:0] offset;
	wire [31:0] PC_F4;
	wire [31:0] PC_D4;
	wire Zero;
	parameter	other = 3'b000,
					beq = 3'b001,
					jal_j = 3'b010,
					jr = 3'b011;
	
	assign offset = Instr[15:0];
	assign Zero = (A == B);
	
	assign PC_F4 = PC_F + 4;
	assign PC_D4 = PC_D + 4;
	
	
	assign npc = (NPCOp == other) 					? PC_F4 :
					 ((NPCOp == beq) & (Zero == 1)) 	? PC_D4 + {{14{offset[15]}},offset,2'b00} :
					 (NPCOp == jal_j) 					? {PC_D[31:28],Instr,2'b00} : 
					 (NPCOp == jr)							? rs :
																  PC_D4 + 4;
																  
endmodule
