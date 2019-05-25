`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:23 11/18/2018 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [11:0] Address,
    output [31:0] Instr
    );
	
	reg [31:0] memory [4095:0];
	integer i;
	
	initial begin
		for(i = 0; i < 4095; i = i + 1)
			memory[i] = 32'h0;
		$readmemh("code.txt",memory);
	end
	
	assign	Instr = memory[Address];

endmodule
