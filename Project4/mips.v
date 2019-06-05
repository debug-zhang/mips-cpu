`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:28 11/20/2018 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
	 
	wire [31:0] PC,nPC,PC_4;
	wire [31:0] Instr;
	wire [31:0] RD1,RD2,WD;
	wire [31:0] ALU_B,ALUResult;
	wire Zero;
	wire [31:0] EXTResult,DMResult;
	wire [4:0] WriteReg;
	 
	wire RegWrite,ALUSrc,MemWrite;
   wire [1:0] RegDst;
	wire [1:0] MemtoReg;
	wire [1:0] MemDst;
	wire [1:0] ExtOp;
	wire [2:0] nPCOp;
   wire [3:0] ALUOp; 
	 
	PC 		PC_p4			(.Clk(clk), .Reset(reset), .nPC(nPC), .PC(PC));
	IM			IM_p4			(.PC(PC[11:2]), .Instr(Instr));
	
	ctrl		ctrl_p4		(.Op(Instr[31:26]), .Func(Instr[5:0]),
								 .RegDst(RegDst), .ExtOp(ExtOp), .ALUOp(ALUOp), .nPCOp(nPCOp), .MemtoReg(MemtoReg), .MemDst(MemDst),
								 .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite));
								 
	mux_3_5	MUX_RegDst	(.a(Instr[20:16]), .b(Instr[15:11]), .c(5'h1f), .select(RegDst), .y(WriteReg));
	
	GRF		GRF_p4		(.Clk(clk), .Reset(reset), .WE(RegWrite), .A1(Instr[25:21]), .A2(Instr[20:16]), .A3(WriteReg), .WD(WD), .WPC(PC), .RD1(RD1), .RD2(RD2));
	
	mux_2_32	MUX_ALUSrc	(.a(RD2), .b(EXTResult), .select(ALUSrc), .y(ALU_B));
	
	ALU		ALU_p4		(.A(RD1), .B(ALU_B), .ALUOp(ALUOp), .Zero(Zero), .Result(ALUResult));
	DM			DM_p4			(.Clk(clk), .Reset(reset), .WE(MemWrite), .MemDst(MemDst), .A(ALUResult[11:0]), .WD(RD2), .pc(PC), .addr(ALUResult), .RD(DMResult));
	
	mux_3_32	MUX_MemtoReg (.a(ALUResult), .b(DMResult), .c(PC_4), .select(MemtoReg), .y(WD));
	
	EXT		EXT_p4		(.Imm_16(Instr[15:0]), .ExtOp(ExtOp), .Imm_32(EXTResult));
	nPC		nPC_p4		(.Instr(Instr[25:0]), .pc(PC), .rs(ALUResult), .Zero(Zero), .nPCOp(nPCOp), .npc(nPC), .pc_4(PC_4));	

endmodule
