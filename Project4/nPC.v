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
module nPC(
    input [25:0] Instr,
    input [31:0] pc,
    input [31:0] rs,
	 input Zero,
    input [2:0] nPCOp,
    output [31:0] npc,
    output [31:0] pc_4
    );

	wire [15:0] offset;
	parameter	other = 3'b000,
					beq = 3'b001,
					jal = 3'b010,
					jr = 3'b011;
	
	assign offset = Instr[15:0];
	
	assign pc_4 = pc + 4;
	
	assign npc = (nPCOp == other) 				? pc_4 :
					 (nPCOp == beq && Zero == 1) 	? pc_4 + {{14{offset[15]}},offset,2'b00} :
					 (nPCOp == jal) 					? {pc[31:28],Instr,2'b0} : 
					 (nPCOp == jr)						? rs :
															  pc_4;

endmodule
