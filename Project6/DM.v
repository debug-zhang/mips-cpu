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
	 input [3:0] BE,
    input [31:0] WriteData,
	 input [31:0] pc,
	 input [31:0] addr,
    output[31:0] ReadData
    );

	reg [31:0] memory[4095:0];
	wire [11:0] A;
	wire [31:0] AExt;
	integer i;
	
	initial begin
		for(i = 0; i < 4095; i = i + 1)
				memory[i] = 32'h0;
	end
	
	assign A = addr[13:2];
	assign AExt = {18'b0,A,2'b0};

	assign ReadData = memory[A];
	
	always @ (posedge Clock) begin
		if(Reset == 1)
			for(i = 0; i < 4095; i = i + 1)
				memory[i] = 32'h0;
		else if(MemWrite == 1) begin
			case(BE)
				4'b0001:	begin
								memory[A][7:0] = WriteData[7:0];
								$display("%d@%h: *%h <= %h", $time, pc, AExt,memory[A]);
							end
				4'b0010: begin
								memory[A][15:8] = WriteData[7:0];
								$display("%d@%h: *%h <= %h", $time, pc, AExt,memory[A]);
							end
				4'b0100: begin
								memory[A][23:16] = WriteData[7:0];
								$display("%d@%h: *%h <= %h", $time, pc, AExt,memory[A]);
							end
				4'b1000: begin
								memory[A][31:24] = WriteData[7:0];
								$display("%d@%h: *%h <= %h", $time, pc, AExt,memory[A]);
							end
				
				4'b0011: begin
								memory[A][15:0] = WriteData[15:0];
								$display("%d@%h: *%h <= %h", $time, pc, AExt,memory[A]);
							end
				4'b1100: begin
								memory[A][31:16] = WriteData[15:0];
								$display("%d@%h: *%h <= %h", $time, pc, AExt,memory[A]);
							end
				
				4'b1111: begin
								memory[A] = WriteData;
								$display("%d@%h: *%h <= %h", $time, pc, AExt,memory[A]);
							end
			endcase
		end
	end

endmodule
