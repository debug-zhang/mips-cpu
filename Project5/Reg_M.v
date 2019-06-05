`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:58:10 11/28/2018 
// Design Name: 
// Module Name:    Reg_M 
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
module Reg_M(
    input Clock,
    input Reset,
    input [31:0] ALUOut,
    input [31:0] ALU_B,
    input [31:0] IR_E,
    input [31:0] PC4_E,
    input [4:0] A3_E,
	 output reg [31:0] IR_M,
    output reg [31:0] V2_M,
    output reg [31:0] AO_M,
    output reg [4:0] A3_M,
    output reg [31:0] PC4_M
    );
	
	always @ (posedge Clock) begin
		if(Reset == 1) begin
			IR_M 	<= 0;
			V2_M	<= 0;
			AO_M	<= 0;
			A3_M	<= 0;
			PC4_M	<= 32'h0000_3000;
		end
		else begin
			IR_M 	<= IR_E;
			V2_M	<= ALU_B;
			AO_M	<= ALUOut;
			A3_M	<= A3_E;
			PC4_M	<= PC4_E;
		end
	end

endmodule
