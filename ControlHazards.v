`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:33:36 12/10/2018 
// Design Name: 
// Module Name:    ControlHazards 
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
module ControlHazards(
	 input [31:0] IR,
	 input  [1:0] TnewSrc,
	 output [1:0] Tuse_rs,
	 output [1:0] Tuse_rt,
	 output [1:0] Tnew
    );
	
	wire [5:0] Op;
	wire [5:0] Func;
	wire [4:0] Rt;
	wire cal_r,cal_i,MF,MT,MD,load,store,branch,j,jr,jal,jalr;
	wire [1:0] Tnew_E,Tnew_M,Tnew_W;
	
	reg LB,LBU,LH,LHU,LW,
		 SB,SH,SW,
		 ADD,ADDU,SUB,SUBU,
		 MULT,MULTU,DIV,DIVU,
		 SLL,SRL,SRA,SLLV,SRLV,SRAV,
		 AND,OR,XOR,NOR,
		 ADDI,ADDIU,ANDI,ORI,XORI,LUI,
		 SLT,SLTI,SLTIU,SLTU,
		 BEQ,BNE,BLEZ,BGTZ,BLTZ,BGEZ,
		 J,JAL,JALR,JR,
		 MFHI,MFLO,MTHI,MTLO;
	
	initial begin
		{LB,LBU,LH,LHU,LW,SB,SH,SW,
		 ADD,ADDU,SUB,SUBU,
		 MULT,MULTU,DIV,DIVU,
		 SLL,SRL,SRA,SLLV,SRLV,SRAV,
		 AND,OR,XOR,NOR,
		 ADDI,ADDIU,ANDI,ORI,XORI,LUI,
		 SLT,SLTI,SLTIU,SLTU,
		 BEQ,BNE,BLEZ,BGTZ,BLTZ,BGEZ,
		 J,JAL,JALR,JR,
		 MFHI,MFLO,MTHI,MTLO} = 0;
	end
	
	assign Op = IR[31:26];
	assign Func = IR[5:0];
	assign Rt = IR[20:16];
	
	always @ (IR or Op or Func or Rt) begin
		{LB,LBU,LH,LHU,LW,SB,SH,SW,
		 ADD,ADDU,SUB,SUBU,
		 MULT,MULTU,DIV,DIVU,
		 SLL,SRL,SRA,SLLV,SRLV,SRAV,
		 AND,OR,XOR,NOR,
		 ADDI,ADDIU,ANDI,ORI,XORI,LUI,
		 SLT,SLTI,SLTIU,SLTU,
		 BEQ,BNE,BLEZ,BGTZ,BLTZ,BGEZ,
		 J,JAL,JALR,JR,
		 MFHI,MFLO,MTHI,MTLO} = 42'b0;
		case(Op)
			6'b000000:	begin
								case(Func)
									6'b000000:	SLL 	= 1;
									6'b000010:	SRL	= 1;
									6'b000011:	SRA	= 1;
									6'b000100:	SLLV	= 1;
									6'b000110:	SRLV	= 1;
									6'b000111:	SRAV	= 1;
									6'b001000:	JR		= 1;
									6'b001001:	JALR	= 1;
									6'b010000:	MFHI	= 1;
									6'b010001:	MTHI	= 1;
									6'b010010:	MFLO	= 1;
									6'b010011:	MTLO	= 1;
									6'b011000:	MULT	= 1;
									6'b011001:	MULTU	= 1;
									6'b011010:	DIV 	= 1;
									6'b011011:	DIVU	= 1;
									6'b100000:	ADD 	= 1;
									6'b100001:	ADDU	= 1;
									6'b100010:	SUB	= 1;
									6'b100011:	SUBU	= 1;
									6'b100100:	AND 	= 1;
									6'b100101:	OR		= 1;
									6'b100110:	XOR	= 1;
									6'b100111:	NOR	= 1;
									6'b101010:	SLT	= 1;
									6'b101011:	SLTU	= 1;
								endcase
							end
			6'b000001:	begin
								case(Rt)
									5'b00000:	BLTZ = 1;
									5'b00001:	BGEZ = 1;
								endcase
							end
			6'b000010:	J		= 1;
			6'b000011:	JAL	= 1;
			6'b000100:	BEQ 	= 1;
			6'b000101:	BNE 	= 1;
			6'b000110:	BLEZ 	= 1;
			6'b000111:	BGTZ 	= 1;
			6'b001000:	ADDI 	= 1;
			6'b001001:	ADDIU = 1;
			6'b001010:	SLTI	= 1;
			6'b001011:	SLTIU	= 1;
			6'b001100:	ANDI 	= 1;
			6'b001101:	ORI	= 1;
			6'b001110:	XORI	= 1;
			6'b001111:	LUI	= 1;
			6'b100000:	LB		= 1;
			6'b100001:	LH		= 1;
			6'b100011:	LW		= 1;
			6'b100100:	LBU	= 1;
			6'b100101:	LHU	= 1;
			6'b101000:	SB		= 1;
			6'b101001:	SH		= 1;
			6'b101011:	SW		= 1;
			default:	{LB,LBU,LH,LHU,LW,SB,SH,SW,
						 ADD,ADDU,SUB,SUBU,
						 MULT,MULTU,DIV,DIVU,
						 SLL,SRL,SRA,SLLV,SRLV,SRAV,
						 AND,OR,XOR,NOR,
						 ADDI,ADDIU,ANDI,ORI,XORI,LUI,
						 SLT,SLTI,SLTIU,SLTU,
						 BEQ,BNE,BLEZ,BGTZ,BLTZ,BGEZ,
						 J,JAL,JALR,JR,
						 MFHI,MFLO,MTHI,MTLO} = 42'b0;
		endcase
	end

	assign cal_r = ADD | ADDU | AND | NOR | OR | SUB | SUBU | XOR | SLL | SLLV | SLT | SLTU | SRA | SRAV | SRL | SRLV;
	assign cal_i = ADDI | ADDIU | ANDI | ORI | XORI | SLTI | SLTIU | LUI;
	assign MF	 = MFHI | MFLO;
	assign MT	 = MTHI | MTLO;
	assign MD	 = MULT | MULTU | DIV | DIVU;
	assign load = LB | LBU | LH | LHU | LW;
	assign store = SB | SH | SW;
	assign branch = BEQ | BGEZ | BGTZ | BLEZ | BLTZ | BNE;
	assign j = J;
	assign jr = JR;
	assign jal = JAL;
	assign jalr = JALR;
	
	assign Tnew_E = (cal_r | cal_i | MF)		? 2'b01 :
															  2'b10;
	assign Tnew_M = (cal_r | cal_i | MF)		? 2'b00 :
															  2'b01;
	assign Tnew_W = (cal_r | cal_i | MF)		? 2'b00 :
															  2'b00;
													  
	assign Tuse_rs = (branch | jr | jalr)								? 2'b00 :
						  (cal_r | cal_i | MT | MD | load | store) 	? 2'b01 :
																					  2'b11;
	
	assign Tuse_rt = (branch) 		? 2'b00 : 
						  (cal_r | MD)	? 2'b01 :
						  (store)		? 2'b10 :
											  2'b11;
										 
	assign Tnew = (TnewSrc == 2'b00 ) ? Tnew_E :
					  (TnewSrc == 2'b01 ) ? Tnew_M :
													Tnew_W;
endmodule
