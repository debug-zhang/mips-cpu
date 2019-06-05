`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:41:48 11/21/2018
// Design Name:   mips
// Module Name:   E:/ComputerOrganization/Verilog/Project4/p4_test.v
// Project Name:  Project4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module p4_test;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#5;
		reset = 0;
		#5;
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

