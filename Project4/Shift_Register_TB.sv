`timescale 1ns/1ns

module Shift_Register_P6();
	logic sIn, clk, rst;
	wire sOut;

	Shift_Register_P5 shift_register(.sIn(sIn), .clk(clk), .rst(rst), .sOut(sOut));

	always #600 clk = ~clk;
	always #1400 sIn = $random();

	initial begin
		clk = 0;
		sIn = $random();
		rst = 0;
		#10000;
		rst = 1;
		#2000;
		rst = 0;
		#4000;
		$stop;
	end
endmodule