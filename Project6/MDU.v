`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:08:16 12/04/2018 
// Design Name: 
// Module Name:    MDU 
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
module MDU(
    input Clock,
    input Reset,
    input Start,
    input [31:0] A,
    input [31:0] B,
    input [2:0] MDUOp,
    output reg [31:0] HI,
    output reg [31:0] LO,
    output Busy
    );
	 
	integer delay;
	parameter DIV	= 3'b000,
				 DIVU	= 3'b001,
				 MULT = 3'b010,
				 MULTU= 3'b011,
				 MTHI	= 3'b100,
				 MTLO = 3'b101;

	initial begin
		HI = 0;
		LO = 0;
		delay = 0;
	end
	
	always @(posedge Clock) begin
		if(Reset == 1) begin
			HI = 0;
			LO = 0;
			delay = 0;
		end
		else if(Start==1 && delay==0) begin
			case(MDUOp)
				DIV:	begin
							HI = $signed(A) % $signed(B);
							LO = $signed(A) / $signed(B);
							delay = 10;
						end
				DIVU:	begin
							HI = A % B;
							LO = A / B;
							delay = 10;
						end
				MULT:	begin
							{HI,LO} = $signed(A) * $signed(B);
							delay = 5;
						end
				MULTU:begin
							{HI,LO} = A * B;
							delay = 5;
						end
				MTHI: begin
							HI = A;
							delay = 0;
						end
				MTLO: begin
							LO = A;
							delay = 0;
						end
				default:	delay = 0;
			endcase
		end
		if(delay != 0)
			delay = delay - 1;
	end
	
	assign Busy = (delay != 0);

endmodule
