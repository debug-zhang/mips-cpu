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
module mux_3_5(
	 input [4:0] a,b,c,
	 input [1:0] select,
	 output [4:0] y
    );
	 
	 assign y = (select == 2) ? c :
					(select == 1) ? b :
										 a;
endmodule

module mux_3_32(
	 input [31:0] a,b,c,
	 input [1:0] select,
	 output [31:0] y
    );
	 
	 assign y = (select == 2) ? c :
					(select == 1) ? b :
										 a;
endmodule

module mux_4_32(
	 input [31:0] a,b,c,d,
	 input [2:0] select,
	 output [31:0] y
    );
	 
	 assign y = (select == 3) ? d :
					(select == 2) ? c :
					(select == 1) ? b :
										 a;
endmodule

module mux_5_32(
	 input [31:0] a,b,c,d,e,
	 input [2:0] select,
	 output [31:0] y
    );
 
	 assign y = (select == 4) ? e :
					(select == 3) ? d :
					(select == 2) ? c :
					(select == 1) ? b :
										 a;

endmodule

