`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:59:05 12/11/2018 
// Design Name: 
// Module Name:    MDU_Ctrl 
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
module MDU_Ctrl(
	 input [31:0] IR_D,
	 input [31:0] IR_E,
    input Busy,
    output Start,
	 output [1:0] Read,
    output Stall_MDU
    );
	
	wire [5:0] Op_D,Op_E;
	wire [5:0] Func_D,Func_E;
	
	assign Op_D = IR_D[31:26];
	assign Func_D = IR_D[5:0];
	assign Op_E = IR_E[31:26];
	assign Func_E = IR_E[5:0];
	
	assign Start		= (Busy==0) & (Op_E==0) & (Func_E>=6'b010000 && Func_E<=6'b011011 && Func_E!=6'b010000 && Func_E!=6'b010010);
	assign Read			= (Busy==0) & (Op_E==0) & (Func_E==6'b010000) ? 2'b01 :
							  (Busy==0) & (Op_E==0) & (Func_E==6'b010010) ? 2'b10 :
																							2'b00;
	assign Stall_MDU	= (Busy==1 || Start==1) & (Op_D==0) & (Func_D>=6'b010000 && Func_D<=6'b011011);


endmodule
