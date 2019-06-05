`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:36:08 11/17/2018 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input Clock,
    input Reset,
    input RegWrite,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
	 input [31:0] WPC,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
	 
	reg [31:0] register[31:0];
	integer i;
	
	initial begin
		for(i = 0; i < 32; i = i + 1)
			register[i] = 0;
	end
	
	assign ReadData1 = (ReadReg1 == WriteReg && WriteReg != 0 && RegWrite == 1) ? WriteData : register[ReadReg1];
	assign ReadData2 = (ReadReg2 == WriteReg && WriteReg != 0 && RegWrite == 1) ? WriteData : register[ReadReg2];
	
	always @ (posedge Clock) begin
		if(Reset == 1)
			for(i = 0; i < 32; i = i + 1)
				register[i] = 32'h0;
		else if(RegWrite == 1 && WriteReg != 0) begin
			register[WriteReg] = WriteData;
			$display("%d@%h: $%d <= %h", $time, WPC, WriteReg,WriteData);
		end
	end

endmodule
