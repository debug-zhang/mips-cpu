`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:54:27 10/30/2018 
// Design Name: 
// Module Name:    four 
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
module four(
    input clk,
    output [2:0] q,
    output cout
    );

	parameter s1 = 3'b010,
				 s2 = 3'b011,
				 s3 = 3'b111,
				 s4 = 3'b110,
				 s5 = 3'b100,
				 s6 = 3'b000;
	
	always @ (posedge clk) begin
		case(q)
			s1:	q <= s2;
			s2:	q <= s3;
			s3:	q <= s4;
			s4:	q <= s5;
			s5:	q <= s6;
			s6:	q <= s1;
			default:q <= s1;
		endcase
		if(q == s6)
			cout <= 1;
		else
			cout <= 0;
	end

endmodule
