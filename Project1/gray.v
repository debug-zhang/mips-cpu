`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:57:21 10/28/2018 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output reg [2:0] Output,
    output reg Overflow
    );
	 
	reg [2:0] bin;
	integer i;
	
	initial begin
		Output <= 0;
		Overflow <= 0;
		bin <= 0;
	end
	
	always @(posedge Clk) begin
		if(Reset) begin
			Output <= 0;
			Overflow <= 0;
			bin <= 0;
		end
		else if(En) begin
			if(bin == 7) begin
				Output <= 0;
				Overflow <= 1;
				bin <= 0;
			end
			else begin
				bin = bin + 1;
				for(i=0;i<2;i=i+1)
					Output[i] = bin[i] ^ bin[i+1];
				Output[2] = bin[2];
			end
		end
	end

endmodule
