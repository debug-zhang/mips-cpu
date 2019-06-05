`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:51:08 10/28/2018 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C
    );
	 
	 always @(*) begin
		case(ALUOp)
			3'b000: C <= A + B;
			3'b001: C <= A - B;
			3'b010: C <= A & B;
			3'b011: C <= A | B;
			3'b100: C <= A >> B;
			3'b101: C <= $signed(A) >>> B;
		endcase
	end
endmodule
