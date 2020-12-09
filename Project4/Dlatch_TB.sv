`timescale 1ns/1ns

module Clocked_Dlatch_With_Delay_TB_P3();
	logic D, clk;
	logic Q, Q_bar;
	Clocked_Dlatch_With_Delay_P2 Dlatch(.D(D), .clk(clk), .Q(Q), .Q_bar(Q_bar));
	logic [20]know;

	always #1 know = know + 1;
	always #60 if (know < 1000) D = ~D;
	always #200 if (know < 1000) clk = ~clk;

	initial begin
		know = 0;
		Q = 1'bx;
		Q_bar = 1'bx;
		#5;
		clk = 1'b0;
		D = 1'b0;
		#1000;
		D = 1'b1;
		clk = 1'b1;
		#60;
		clk = 1'b0;
		D = 0'b0;
		#60;
		$stop;
	end
endmodule