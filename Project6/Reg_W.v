`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:10:30 11/28/2018 
// Design Name: 
// Module Name:    Reg_W 
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
module Reg_W(
    input Clock,
    input Reset,
    input [31:0] IR_M,
    input [4:0] A3_M,
    input [31:0] AMO_M,
    input [31:0] PC4_M,
    input [31:0] DMOut,
	output reg [31:0] IR_W,
    output reg [4:0] A3_W,
    output reg [31:0] PC4_W,
    output reg [31:0] AMO_W,
    output reg [31:0] DR_W
    );
	
	initial begin
		IR_W	= 0;
		A3_W	= 0;
		PC4_W	= 32'h0000_3000;
		AMO_W	= 0;
		DR_W	= 0;
	end
	
	always @ (posedge Clock) begin
		if(Reset == 1) begin
			IR_W	<= 0;
			A3_W	<= 0;
			PC4_W	<= 32'h0000_3000;
			AMO_W	<= 0;
			DR_W	<= 0;
		end
		else begin
			IR_W	<= IR_M;
			A3_W	<= A3_M;
			PC4_W	<= PC4_M;
			AMO_W	<= AMO_M;
			DR_W	<= DMOut;
		end
	end

endmodule

