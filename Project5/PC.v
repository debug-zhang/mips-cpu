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
    input Clock,
	 input Reset,
	 input Stop,
	 input [31:0] NextPC,
    output reg [31:0] PC
    );
	 
	initial begin
		PC = 32'h0000_3000;
	end

	always @ (posedge Clock) begin
		if(Reset == 1)
			PC = 32'h0000_3000;
		else if(Stop == 1)
			PC = PC;
		else
			PC = NextPC;
	end

endmodule
