`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:57:08 11/18/2018 
// Design Name: 
// Module Name:    control 
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
module ctrl(
	 input [31:0] IR,
    input [5:0] Op,
    input [5:0] Func,
	 input [4:0] Rt,
    output [1:0] RegDst,
    output RegWrite,
    output ALUSrc,
    output MemWrite,
    output [1:0] MemtoReg,
    output [1:0] ExtOp,
    output [3:0] ALUOp,
	 output [2:0] MDUOp,
	 output [3:0] NPCOp
    );
	 
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
		 MFHI,MFLO,MTHI,MTLO} = 42'b0;
	end

	assign	RegDst 	= (ADD | ADDU | AND | NOR | OR | SUB | SUBU | XOR | SLL | SLLV | SLT | SLTU | SRA | SRAV | SRL | SRLV | MFHI | MFLO | JALR) ? 2'b01 :
							  (JAL)	? 2'b10 :
										  2'b00;
										  
	assign	RegWrite = (ADD | ADDU | AND | NOR | OR | SUB | SUBU | XOR | SLL | SLLV | SLT | SLTU | SRA | SRAV | SRL | SRLV | ADDI | ADDIU | ANDI | ORI | XORI | SLTI | SLTIU | LUI | MFHI | MFLO | JAL | JALR | LB | LBU | LH | LHU | LW)	? 1 :
										  0;
										  
	assign	ALUSrc 	= (ADDI | ADDIU | ANDI | ORI | XORI | SLTI | SLTIU | LUI | LB | LBU | LH | LHU | LW | SB | SH | SW) ? 1 :
										  0;
										  
	assign	MemWrite = (SB | SH | SW) ? 1 :
										  0;
										  
	assign	MemtoReg = (LB | LBU | LH | LHU | LW) ? 2'b01 :
							  (JAL | JALR) ? 2'b10 :
										  2'b00;
										  
	assign	ExtOp 	= (ANDI | ORI | XORI) ? 2'b01 :
							  (LUI)	 ? 2'b10 :
											2'b00;
											  
	assign	ALUOp 	= (AND | ANDI)		? 4'b0001 :
							  (NOR)				? 4'b0010 :
							  (OR | ORI)		? 4'b0011 :
							  (SUB | SUBU)		? 4'b0100 :
							  (XOR | XORI)		? 4'b0101 :
							  (SLL)				? 4'b0110 :
							  (SLLV)				? 4'b0111 :
							  (SLT | SLTI)		? 4'b1000 :
							  (SLTU | SLTIU)	? 4'b1001 :
							  (SRA)				? 4'b1010 :
							  (SRAV)				? 4'b1011 :
							  (SRL)				? 4'b1100 :
							  (SRLV)				? 4'b1101 :
													  4'b0000;
							  
	assign	MDUOp		= (DIVU) ? 3'b001 :
							  (MULT) ? 3'b010 :
							  (MULTU)? 3'b011 :
							  (MTHI) ? 3'b100 :
							  (MTLO) ? 3'b101 :
										  3'b000;



	assign	NPCOp 	= (BEQ)			? 4'b0001 :
							  (BGEZ)			? 4'b0010 :
							  (BGTZ)			? 4'b0011 :
							  (BLEZ)			? 4'b0100 :
							  (BLTZ)			? 4'b0101 :
							  (BNE)			? 4'b0110 :
							  (J | JAL)		? 4'b0111 :
							  (JALR | JR)	? 4'b1000 :
												  4'b0000;
	
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
endmodule
