`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:16:20 12/04/2018 
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

//output
	//ctrl_D,E,M,W
	wire [1:0] RegDst_D,RegDst_E,RegDst_M,RegDst_W;
	wire RegWrite_D,RegWrite_E,RegWrite_M,RegWrite_W;
	wire ALUSrc_D,ALUSrc_E,ALUSrc_M,ALUSrc_W;
   wire MemWrite_D,MemWrite_E,MemWrite_M,MemWrite_W;
   wire [1:0] MemtoReg_D,MemtoReg_E,MemtoReg_M,MemtoReg_W;
   wire [1:0] ExtOp_D,ExtOp_E,ExtOp_M,ExtOp_W;
   wire [3:0] ALUOp_D,ALUOp_E,ALUOp_M,ALUOp_W;
	wire [2:0] MDUOp_D,MDUOp_E,MDUOp_M,MDUOp_W;
	wire [3:0] NPCOp_D,NPCOp_E,NPCOp_M,NPCOp_W;
	//PC
	wire [31:0] PC_F;
	//IM
	wire [31:0] IR_F;
	//Reg_D
	wire [31:0] IR_D;
	wire [31:0] PC_D;
	//MFRSD
	wire [31:0] RD1;
	//MFRTD
	wire [31:0] RD2;
	//NPC
	wire [31:0] NextPC;
	//GRF
	wire [31:0] ReadData1;
   wire [31:0] ReadData2;
	//EXT
	wire [31:0] EXTOut;
	//A3_Mux
	wire [4:0] WriteReg;
	//Reg_E
	wire [31:0] IR_E;
	wire [31:0] V1_E;
	wire [31:0] V2_E;
	wire [4:0] A1_E;
	wire [4:0] A2_E;
	wire [4:0] A3_E;
	wire [31:0] E32_E;
	wire [31:0] PC_E;
	//MFRSE
	wire [31:0] ALU_A;
	//MFRTE
	wire [31:0] ALU_B;
	//ALUSrc
	wire [31:0] ALU_B_E32;
	//ALU
	wire [31:0] ALUOut;
	//MDU_Ctrl
	wire Start;
	wire [1:0] Read;
	wire Stall_MDU;
	//MDU
	wire [31:0] HI;
   wire [31:0] LO;
   wire Busy;
	//ALU_MDU_Out
	wire [31:0] ALU_MDU_Out;
	//Reg_M
	wire [31:0] IR_M;
   wire [31:0] V2_M;
   wire [31:0] AMO_M;
   wire [4:0] A3_M;
   wire [31:0] PC_M;
	//RTMsel
	wire [31:0] WriteData_DM;
	//BE
	wire [3:0] BEOp;
	//DM
	wire [31:0] ReadData_DM;
	//Reg_W
	wire [31:0] IR_W;
   wire [4:0] A3_W;
   wire [31:0] PC_W;
   wire [31:0] AMO_W;
   wire [31:0] DR_W;
	//BE_EXT
	wire [31:0] DMExt;
	//MemtoReg
	wire [31:0] WriteData;
	//Hazards
	wire Stall;
   wire [1:0] RSDsel; 
   wire [1:0] RTDsel; 
   wire [1:0] RSEsel;
   wire [1:0] RTEsel;
   wire [1:0] RTMsel;
//output
	
//F级
	PC PC_P6 (
    .Clock(clk), 
    .Reset(reset), 
    .Stop(Stall), 
    .NextPC(NextPC), 
    .PC(PC_F)
    );
	 
	IM IM_P6 (
    .Address(PC_F[13:2]-12'hc00), 
    .Instr(IR_F)
    );
	 
	Reg_D Reg_D_P6 (
    .Clock(clk), 
    .Reset(reset), 
    .Enable(Stall), 
    .IR_F(IR_F), 
    .PC_F(PC_F), 
    .IR_D(IR_D), 
    .NPC_D(PC_D)
    );
//D级

//D级
	ctrl D_ctrl (
    .IR(IR_D),
	 .Op(IR_D[31:26]), 
    .Func(IR_D[5:0]), 
    .Rt(IR_D[20:16]), 
    .RegDst(RegDst_D), 
    .RegWrite(RegWrite_D), 
    .ALUSrc(ALUSrc_D), 
    .MemWrite(MemWrite_D), 
    .MemtoReg(MemtoReg_D), 
    .ExtOp(ExtOp_D), 
    .ALUOp(ALUOp_D),
	 .MDUOp(MDUOp_D), 
    .NPCOp(NPCOp_D)
    );
	
	mux_3_32 MFRSD_P6 (
    .a(ReadData1), 
    .b(WriteData), 
    .c(AMO_M), 
    .select(RSDsel), 
    .y(RD1)
    );
	
	mux_3_32 MFRTD_P6 (
    .a(ReadData2), 
    .b(WriteData), 
    .c(AMO_M), 
    .select(RTDsel), 
    .y(RD2)
    );
	 
	NPC NPC_P6 (
    .Instr(IR_D[25:0]), 
    .PC_F(PC_F), 
    .PC_D(PC_D), 
    .rs(RD1), 
    .A(RD1), 
    .B(RD2), 
    .NPCOp(NPCOp_D), 
    .npc(NextPC)
    );
	
	GRF GRF_P6 (
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
	 
	EXT EXT_P6 (
    .Imm_16(IR_D[15:0]), 
    .ExtOp(ExtOp_D), 
    .Imm_32(EXTOut)
    );
	 
	mux_3_5 A3_Mux_P6 (
    .a(IR_D[20:16]), 
    .b(IR_D[15:11]), 
    .c(5'h1f), 
    .select(RegDst_D), 
    .y(WriteReg)
    );
	 
	Reg_E Reg_E_P6 (
    .Clock(clk), 
    .Reset(reset | Stall), 
    .IR_D(IR_D), 
    .RF_RD1(RD1), 
    .RF_RD2(RD2), 
    .PC4_D(PC_D), 
    .EXT(EXTOut), 
    .Rs_IR_D(IR_D[25:21]), 
    .Rt_IR_D(IR_D[20:16]), 
    .Rd_IR_D(WriteReg), 
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
	ctrl E_ctrl (
	 .IR(IR_E),
    .Op(IR_E[31:26]), 
    .Func(IR_E[5:0]), 
    .Rt(IR_E[20:16]), 
    .RegDst(RegDst_E), 
    .RegWrite(RegWrite_E), 
    .ALUSrc(ALUSrc_E), 
    .MemWrite(MemWrite_E), 
    .MemtoReg(MemtoReg_E), 
    .ExtOp(ExtOp_E), 
    .ALUOp(ALUOp_E),
	 .MDUOp(MDUOp_E), 
    .NPCOp(NPCOp_E)
    );

	mux_3_32 MFRSE_P6 (
    .a(V1_E), 
    .b(WriteData), 
    .c(AMO_M), 
    .select(RSEsel), 
    .y(ALU_A)
    );

	mux_3_32 MFRTE_P6 (
    .a(V2_E), 
    .b(WriteData), 
    .c(AMO_M), 
    .select(RTEsel), 
    .y(ALU_B)
    );
	 
	assign ALU_B_E32 = (ALUSrc_E == 0) ? ALU_B : E32_E;
	
	ALU ALU_P6 (
    .A(ALU_A), 
    .B(ALU_B_E32), 
    .s(IR_E[10:6]), 
    .ALUOp(ALUOp_E), 
    .Result(ALUOut)
    );
	
	MDU_Ctrl MDU_Ctrl_P6 (
    .IR_D(IR_D), 
    .IR_E(IR_E), 
    .Busy(Busy), 
    .Start(Start), 
    .Read(Read), 
    .Stall_MDU(Stall_MDU)
    );
	 
	MDU MDU_P6 (
    .Clock(clk), 
    .Reset(reset), 
    .Start(Start), 
    .A(ALU_A), 
    .B(ALU_B_E32), 
    .MDUOp(MDUOp_E), 
    .HI(HI), 
    .LO(LO), 
    .Busy(Busy)
    );
	 
	assign ALU_MDU_Out = (Read == 1) ? HI :
								(Read == 2) ? LO :
												  ALUOut;
	
	Reg_M Reg_M_P6 (
    .Clock(clk), 
    .Reset(reset), 
    .ALU_MDU_Out(ALU_MDU_Out), 
    .ALU_B(ALU_B), 
    .IR_E(IR_E), 
    .PC4_E(PC_E), 
    .A3_E(A3_E), 
    .IR_M(IR_M), 
    .V2_M(V2_M), 
    .AMO_M(AMO_M), 
    .A3_M(A3_M), 
    .PC4_M(PC_M)
    );
//M级

//M级
	ctrl M_ctrl (
	 .IR(IR_M),
    .Op(IR_M[31:26]), 
    .Func(IR_M[5:0]), 
    .Rt(IR_M[20:16]),  
    .RegDst(RegDst_M), 
    .RegWrite(RegWrite_M), 
    .ALUSrc(ALUSrc_M), 
    .MemWrite(MemWrite_M), 
    .MemtoReg(MemtoReg_M), 
    .ExtOp(ExtOp_M), 
    .ALUOp(ALUOp_M),
	 .MDUOp(MDUOp_M), 
    .NPCOp(NPCOp_M)
    );
	
	BE BE_P6 (
    .Op(IR_M[31:26]), 
    .Addr(AMO_M[1:0]), 
    .BEOp(BEOp)
    );
	
	assign WriteData_DM = (RTMsel == 1) ? WriteData : V2_M;

	DM DM_P6 (
    .Clock(clk), 
    .Reset(reset), 
    .MemWrite(MemWrite_M), 
    .BE(BEOp), 
    .WriteData(WriteData_DM), 
    .pc(PC_M), 
    .addr(AMO_M), 
    .ReadData(ReadData_DM)
    );
	 
	Reg_W Reg_W_P6 (
    .Clock(clk), 
    .Reset(reset), 
    .IR_M(IR_M), 
    .A3_M(A3_M), 
    .AMO_M(AMO_M), 
    .PC4_M(PC_M), 
    .DMOut(ReadData_DM), 
    .IR_W(IR_W), 
    .A3_W(A3_W), 
    .PC4_W(PC_W), 
    .AMO_W(AMO_W), 
    .DR_W(DR_W)
    );
//W级

//W级
	ctrl W_ctrl (
	 .IR(IR_W),
    .Op(IR_W[31:26]), 
    .Func(IR_W[5:0]), 
    .Rt(IR_W[20:16]), 
    .RegDst(RegDst_W), 
    .RegWrite(RegWrite_W), 
    .ALUSrc(ALUSrc_W), 
    .MemWrite(MemWrite_W), 
    .MemtoReg(MemtoReg_W), 
    .ExtOp(ExtOp_W), 
    .ALUOp(ALUOp_W),
	 .MDUOp(MDUOp_W), 
    .NPCOp(NPCOp_W)
    );
	
	BE_EXT BE_EXT_P6 (
    .DMOut(DR_W), 
    .Addr(AMO_W[1:0]), 
    .Op(IR_W[31:26]), 
    .DMExt(DMExt)
    );
	 
	mux_3_32 MemtoReg_Mux_P6 (
    .a(AMO_W), 
    .b(DMExt), 
    .c(PC_W+8), 
    .select(MemtoReg_W), 
    .y(WriteData)
    );
//W级

//Hazards
	Hazards Hazards_P6 (
	 .IR_D(IR_D), 
    .IR_E(IR_E), 
    .IR_M(IR_M), 
    .IR_W(IR_W), 
	 .A3_E(A3_E), 
    .A3_M(A3_M), 
    .A3_W(A3_W),
	 .W_E(RegWrite_E), 
    .W_M(RegWrite_M), 
    .W_W(RegWrite_W), 
    .Stall_MDU(Stall_MDU), 
    .Stall(Stall), 
    .RSDsel(RSDsel), 
    .RTDsel(RTDsel), 
    .RSEsel(RSEsel), 
    .RTEsel(RTEsel), 
    .RTMsel(RTMsel)
    );
//Hazards

endmodule
