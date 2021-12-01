`timescale 1ns/1ns

module Clocked_Dlatch_With_Delay_TB_P3();
	logic D, clk;
	logic Q, Q_bar;
	Clocked_Dlatch_With_Delay_P2 Dlatch(.D(D), .clk(clk), .Q(Q), .Q_bar(Q_bar));
	logic [20 : 0] know;

	always #1 know = know + 1;
	always #401 if (know < 4000) D = ~D;
	always #200 if (know < 4000) clk = ~clk;

	initial begin
		know = 0;
		Q = 1'bx;
		Q_bar = 1'bx;
		clk = 0;
		#5;
		clk = 1'b1;
		D = 1'b0;
		#4000;
		D = 1'b1;
		clk = 1'b1;
		#460;
		clk = 1'b0;
		D = 0'b0;
		#460;
		D = 1'b1;
		clk = 0'b0;
		#460;
		clk = 1'b1;
		#200;
		clk = 0;
		D = 0;
		#200;
		clk = 1;
		D = 1;
		#100;
		D = 0;
		# 100;
		D = 1;
		#100;
		clk = 0;
		D = 0;
		#100;
		clk = 1;
		D = 1;
		#100;
		clk = 0;
		#100;
		clk = 1;
		#8;
		D = 0;
		#200;
		$stop;
	end
endmodule