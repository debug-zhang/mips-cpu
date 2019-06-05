`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:22 11/17/2018 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
	 input [4:0] s,
    input [3:0] ALUOp,
    output [31:0] Result
    );

	parameter ADD	= 4'b0000,
				 AND	= 4'b0001,
				 NOR  = 4'b0010,
				 OR	= 4'b0011,
				 SUB	= 4'b0100,
				 XOR	= 4'b0101,
				 SLL	= 4'b0110,
				 SLLV	= 4'b0111,
				 SLT	= 4'b1000,
				 SLTU	= 4'b1001,
				 SRA	= 4'b1010,
				 SRAV	= 4'b1011,
				 SRL	= 4'b1100,
				 SRLV	= 4'b1101;
				 
	assign Result = (ALUOp == ADD) ? (A + B) :
						 (ALUOp == AND) ? (A & B) :
						 (ALUOp == NOR) ?	~(A | B) :
						 (ALUOp == OR)  ? (A | B) :
						 (ALUOp == SUB) ? (A - B) :
						 (ALUOp == XOR) ? (A ^ B) :
						 (ALUOp == SLL) ? (B << s) :
						 (ALUOp == SLLV)? (B << A[4:0]) :
						 (ALUOp == SLT) ? ($signed(A) < $signed(B)) :
						 (ALUOp == SLTU)? ({1'b0,A} < {1'b0,B}) :
						 (ALUOp == SRA) ? $signed($signed(B) >>> s) :
						 (ALUOp == SRAV)? $signed($signed(B) >>> A[4:0]) :
						 (ALUOp == SRL) ? (B >> s) :
						 (ALUOp == SRLV)? (B >> A[4:0]) :
												 0;
	
endmodule
