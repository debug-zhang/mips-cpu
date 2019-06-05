`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:12:20 11/20/2018 
// Design Name: 
// Module Name:    mux 
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
module mux_2_32(
	 input [31:0] a,b,
	 input select,
	 output [31:0] y
    );
	 
	 assign y = (select == 0) ? a : b;

endmodule


module mux_3_32(
	 input [31:0] a,b,c,
	 input [1:0] select,
	 output [31:0] y
    );
	 
	 parameter regs = 2'b00,
				  mem  = 2'b01,
				  pc	 = 2'b10;
	 
	 assign y = (select == regs) ? a :
					(select == mem)  ? b : c;

endmodule


module mux_3_5(
	 input [4:0] a,b,c,
	 input [1:0] select,
	 output [4:0] y
    );
	 
	 parameter rt = 2'b00,
				  rd = 2'b01,
				  ra = 2'b10;
	 
	 assign y = (select == rt) ? a :
					(select == rd) ? b : c;

endmodule
