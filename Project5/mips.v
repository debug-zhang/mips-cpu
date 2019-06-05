`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:11 11/28/2018 
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

//F级
	wire [31:0] NewPC;
	wire [31:0] PC_F;
	wire Stop;
	PC PC_P5 (
	 .Clock(clk), 
    .Reset(reset), 
    .Stop(Stop), 
    .NextPC(NewPC), 
    .PC(PC_F)
    );

	wire [31:0] IR_F;
	IM IM_P5 (
    .Address(PC_F[11:2]), 
    .Instr(IR_F)
    );
	
	wire [31:0] IR_D;
	wire [31:0] PC_D;
	Reg_D Reg_D_P5 (
    .Clock(clk), 
    .Reset(reset), 
    .Enable(Stop), 
    .IR_F(IR_F), 
    .PC_F(PC_F), 
    .IR_D(IR_D), 
    .NPC_D(PC_D)
    );
//D级

//D级
	wire [1:0] RegDst_D;
   wire RegWrite_D;
   wire ALUSrc_D;
   wire MemWrite_D;
   wire [1:0]MemtoReg_D;
   wire [1:0] ExtOp_D;
   wire [3:0] ALUOp_D;
	wire [2:0] NPCOp_D;
	ctrl D_ctrl_P5 (
    .Op(IR_D[31:26]), 
    .Func(IR_D[5:0]), 
    .RegDst(RegDst_D), 
    .RegWrite(RegWrite_D), 
    .ALUSrc(ALUSrc_D), 
    .MemWrite(MemWrite_D), 
    .MemtoReg(MemtoReg_D), 
    .ExtOp(ExtOp_D), 
    .ALUOp(ALUOp_D), 
    .NPCOp(NPCOp_D)
    );
	
	//forward
	wire [31:0] WriteData;
	wire [31:0] PC_E;
	wire [31:0] AO_M;
	wire [31:0] PC_M;
	
	wire [31:0] RD1;	
	wire [2:0] RSDsel;
	wire [31:0] ReadData1;
	mux_5_32 MFRSD_P5 (
    .a(ReadData1), 
    .b(WriteData), 
    .c(PC_M+8), 
    .d(AO_M),
    .e(PC_E+8), 
    .select(RSDsel), 
    .y(RD1)
    );	
	wire [31:0] RD2;
	wire [2:0] RTDsel;
	wire [31:0] ReadData2;
	mux_5_32 MFRTD_P5 (
    .a(ReadData2), 
    .b(WriteData), 
    .c(PC_M+8), 
    .d(AO_M),
    .e(PC_E+8), 
    .select(RTDsel), 
    .y(RD2)
    );
	//forward
	
	NPC NPC_P5 (
    .Instr(IR_D[25:0]), 
	 .PC_F(PC_F),
	 .PC_D(PC_D),
    .rs(RD1), 
    .A(RD1), 
    .B(RD2), 
    .NPCOp(NPCOp_D), 
    .npc(NewPC)
    );
	
	wire RegWrite_W;
	wire [4:0] A3_W;
	wire [31:0] PC_W;
	GRF GRF_P5 (
    .Clock(clk), 
    .Reset(reset), 
    .RegWrite(RegWrite_W), 
    .ReadReg1(IR_D[25:21]), 
    .ReadReg2(IR_D[20:16]), 
    .WriteReg(A3_W), 
    .WriteData(WriteData), 
    .WPC(PC_W), 
    .ReadData1(ReadData1), 
    .ReadData2(ReadData2)
    );
	 
	wire [31:0] EXTOut;
	EXT EXT_P5 (
    .Imm_16(IR_D[15:0]), 
    .ExtOp(ExtOp_D), 
    .Imm_32(EXTOut)
    );

	wire [31:0] IR_E;
	wire [31:0] V1_E;
	wire [31:0] V2_E;
	wire [31:0] E32_E;
	wire [4:0] A1_E;
	wire [4:0] A2_E;
	wire [4:0] A3_E;
	Reg_E Reg_E_P5 (
    .Clock(clk), 
    .Reset(reset | Stop), 
    .IR_D(IR_D), 
    .RF_RD1(ReadData1), 
    .RF_RD2(ReadData2), 
    .PC4_D(PC_D), 
    .EXT(EXTOut), 
    .Rs_IR_D(IR_D[25:21]), 
    .Rt_IR_D(IR_D[20:16]), 
    .Rd_IR_D(IR_D[15:11]), 
    .IR_E(IR_E), 
    .V1_E(V1_E), 
    .V2_E(V2_E), 
    .A1_E(A1_E), 
    .A2_E(A2_E), 
    .A3_E(A3_E), 
    .E32_E(E32_E), 
    .PC4_E(PC_E)
    );
//E级

//E级
	wire [1:0] RegDst_E;
   wire RegWrite_E;
   wire ALUSrc_E;
   wire MemWrite_E;
   wire [1:0]MemtoReg_E;
   wire [1:0] ExtOp_E;
   wire [3:0] ALUOp_E;
	wire [2:0] NPCOp_E;
	ctrl E_ctrl_P5 (
    .Op(IR_E[31:26]), 
    .Func(IR_E[5:0]), 
    .RegDst(RegDst_E), 
    .RegWrite(RegWrite_E), 
    .ALUSrc(ALUSrc_E), 
    .MemWrite(MemWrite_E), 
    .MemtoReg(MemtoReg_E), 
    .ExtOp(ExtOp_E), 
    .ALUOp(ALUOp_E), 
    .NPCOp(NPCOp_E)
    );
	
	//forward
	wire [31:0] ALU_A;
	wire [2:0] RSEsel;
	mux_4_32 MFRSE_P5 (
    .a(V1_E), 
    .b(WriteData), 
    .c(PC_M+8), 
    .d(AO_M), 
    .select(RSEsel), 
    .y(ALU_A)
    );	
	wire [31:0] ALU_B;
	wire [2:0] RTEsel;
	mux_4_32 MFRTE_P5 (
    .a(V2_E), 
    .b(WriteData), 
    .c(PC_M+8), 
    .d(AO_M), 
    .select(RTEsel), 
    .y(ALU_B)
    );
	 
	 wire [31:0] ALU_B_E32;
	 assign ALU_B_E32 = (ALUSrc_E == 0) ? ALU_B : E32_E;
	//forward

	wire [31:0] ALUOut;
	wire Zero;
	ALU ALU_P5 (
    .A(ALU_A), 
    .B(ALU_B_E32), 
    .ALUOp(ALUOp_E), 
    .Zero(Zero), 
    .Result(ALUOut)
    );
	 
	 wire [31:0] IR_M;
	 wire [31:0] V2_M;
	 wire [4:0] WriteReg;
	 mux_3_5 A3_Mux_P5 (
    .a(A2_E), 
    .b(A3_E), 
    .c(5'h1f), 
    .select(RegDst_E), 
    .y(WriteReg)
    );
	 
	 wire [4:0] A3_M;
	 Reg_M Reg_M_P5 (
    .Clock(clk), 
    .Reset(reset), 
    .ALUOut(ALUOut), 
    .ALU_B(ALU_B), 
    .IR_E(IR_E), 
    .PC4_E(PC_E), 
    .A3_E(WriteReg), 
    .IR_M(IR_M), 
    .V2_M(V2_M), 
    .AO_M(AO_M), 
    .A3_M(A3_M), 
    .PC4_M(PC_M)
    );
//M级

//M级
	wire [1:0] RegDst_M;
   wire RegWrite_M;
   wire ALUSrc_M;
   wire MemWrite_M;
   wire [1:0]MemtoReg_M;
   wire [1:0] ExtOp_M;
   wire [3:0] ALUOp_M;
	wire [2:0] NPCOp_M;
	ctrl M_ctrl_P5 (
    .Op(IR_M[31:26]), 
    .Func(IR_M[5:0]), 
    .RegDst(RegDst_M), 
    .RegWrite(RegWrite_M), 
    .ALUSrc(ALUSrc_M), 
    .MemWrite(MemWrite_M), 
    .MemtoReg(MemtoReg_M), 
    .ExtOp(ExtOp_M), 
    .ALUOp(ALUOp_M), 
    .NPCOp(NPCOp_M)
    );

	//forward
	wire [31:0] WriteData_DM;
	wire [2:0] RTMsel;
	assign WriteData_DM = (RTMsel == 1) ? WriteData : V2_M;
	//forward

	wire [31:0] ReadData_DM;
	DM DM_P5 (
    .Clock(clk), 
    .Reset(reset), 
    .MemWrite(MemWrite_M), 
    .Address(AO_M[11:2]), 
    .WriteData(WriteData_DM), 
    .pc(PC_M), 
    .addr(AO_M), 
    .ReadData(ReadData_DM)
    );
	 
	 wire [31:0] IR_W;
	 wire [31:0] AO_W;
	 wire [31:0] DR_W;
	 Reg_W Reg_W_P5 (
    .Clock(clk), 
    .Reset(reset), 
    .IR_M(IR_M), 
    .A3_M(A3_M), 
    .AO_M(AO_M), 
    .PC4_M(PC_M), 
    .DMOut(ReadData_DM), 
    .IR_W(IR_W), 
    .A3_W(A3_W), 
    .PC4_W(PC_W), 
    .AO_W(AO_W), 
    .DR_W(DR_W)
    );
//W级

//W级
	wire [1:0] RegDst_W;
   wire ALUSrc_W;
   wire MemWrite_W;
   wire [1:0] MemtoReg_W;
   wire [1:0] ExtOp_W;
   wire [3:0] ALUOp_W;
	wire [2:0] NPCOp_W;
	ctrl W_ctrl_P5 (
    .Op(IR_W[31:26]), 
    .Func(IR_W[5:0]), 
    .RegDst(RegDst_W), 
    .RegWrite(RegWrite_W), 
    .ALUSrc(ALUSrc_W), 
    .MemWrite(MemWrite_W), 
    .MemtoReg(MemtoReg_W), 
    .ExtOp(ExtOp_W), 
    .ALUOp(ALUOp_W), 
    .NPCOp(NPCOp_W)
    );
	 
	mux_3_32 MemtoReg_Mux_P5 (
    .a(AO_W), 
    .b(DR_W), 
    .c(PC_W+8), 
    .select(MemtoReg_W), 
    .y(WriteData)
    );
//W级

//冲突
	Forward Forward_P5 (
    .IR_D(IR_D), 
    .IR_E(IR_E), 
    .IR_M(IR_M), 
    .IR_W(IR_W), 
    .RSDsel(RSDsel), 
    .RTDsel(RTDsel), 
    .RSEsel(RSEsel), 
    .RTEsel(RTEsel),
	 .RTMsel(RTMsel)
    );
	 
	 Stop Stop_P5 (
    .IR_D(IR_D), 
    .IR_E(IR_E), 
    .IR_M(IR_M), 
    .Stop(Stop)
    );
//冲突

endmodule
