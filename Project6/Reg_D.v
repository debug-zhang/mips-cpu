`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:29:34 11/28/2018 
// Design Name: 
// Module Name:    Reg_D 
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
module Reg_D(
    input Clock,
    input Reset,
    input Enable,
    input [31:0] IR_F,
    input [31:0] PC_F,
    output reg [31:0] IR_D,
    output reg [31:0] NPC_D
    );

	initial begin
		IR_D  = 0;
		NPC_D = 0;
	end
	
	always @ (posedge Clock) begin
		if(Reset == 1) begin
			IR_D  <= 0;
			NPC_D <= 0;
		end
		else if(Enable == 1) begin
			IR_D  <= IR_D;
			NPC_D <= NPC_D;
		end
		else begin
			IR_D  <= IR_F;
			NPC_D <= PC_F;
		end
	end

endmodule
