`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:29:45 11/18/2018 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input Clk,
	 input Reset,
	 input [31:0] nPC,
    output reg[31:0] PC
    );
	 
	initial begin
		PC <= 32'h0000_3000;
	end

	always @ (posedge Clk) begin
		if(Reset == 1)	PC <= 32'h0000_3000;
		else				PC <= nPC;
	end

endmodule
