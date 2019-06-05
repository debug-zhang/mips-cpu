`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:47:05 11/18/2018 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input Clock,
	 input Reset,
    input MemWrite,
    input [9:0] Address,
    input [31:0] WriteData,
	 input [31:0] pc,
	 input [31:0] addr,
    output[31:0] ReadData
    );

	reg [31:0] memory[1023:0];
	integer i;
	
	initial begin
		for(i = 0; i < 1023; i = i + 1)
				memory[i] <= 32'h0;
	end

	assign ReadData = memory[Address];
	
	always @ (posedge Clock) begin
		if(Reset == 1)
			for(i = 0; i < 1023; i = i + 1)
				memory[i] <= 32'h0;
		else if(MemWrite == 1) begin
			memory[Address] = WriteData;
			$display("%d@%h: *%h <= %h", $time, pc, addr,WriteData);
		end
	end

endmodule
