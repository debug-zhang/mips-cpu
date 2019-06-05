`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:43:27 11/28/2018 
// Design Name: 
// Module Name:    Reg_E 
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
module Reg_E(
    input Clock,
    input Reset,
    input [31:0] IR_D,
    input [31:0] RF_RD1,
    input [31:0] RF_RD2,
    input [31:0] PC4_D,
    input [31:0] EXT,
    input [4:0] Rs_IR_D,
    input [4:0] Rt_IR_D,
    input [4:0] Rd_IR_D,
    output reg [31:0] IR_E,
    output reg [31:0] V1_E,
    output reg [31:0] V2_E,
    output reg [4:0] A1_E,
    output reg [4:0] A2_E,
    output reg [4:0] A3_E,
    output reg [31:0] E32_E,
    output reg [31:0] PC4_E
    );
	
	initial begin
		IR_E 	= 0;
		V1_E 	= 0;
		V2_E 	= 0;
		A1_E 	= 0;
		A2_E 	= 0;
		A3_E 	= 0;
		E32_E = 0;
		PC4_E = 32'h0000_3000;
	end
	
	always @ (posedge Clock) begin
		if(Reset == 1) begin
			IR_E 	<= 0;
			V1_E 	<= 0;
			V2_E 	<= 0;
			A1_E 	<= 0;
			A2_E 	<= 0;
			A3_E 	<= 0;
			E32_E <= 0;
			PC4_E <= 32'h0000_3000;
		end
		else begin
			IR_E 	<= IR_D;
			V1_E 	<= RF_RD1;
			V2_E 	<= RF_RD2;
			A1_E 	<= Rs_IR_D;
			A2_E 	<= Rt_IR_D;
			A3_E 	<= Rd_IR_D;
			E32_E <= EXT;
			PC4_E <= PC4_D;
		end
	end

endmodule
