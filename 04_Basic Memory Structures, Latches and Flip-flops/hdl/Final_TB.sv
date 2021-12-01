`timescale 1ns/1ns

module Final_TB_P10();
	logic clk, D, rst;
	wire Q, Q_bar;
	wire Q2, Q2_bar;
	logic [20]know;

	always #1 know++;
	always #100 if (know < 10000) clk = ~clk;
	always #201 if (know < 10000) D = $random();
	always #430 if (know < 10000) rst = $random();

	D_Flip_Flop_Reset_Always_P9 FlipFlop(D, clk, rst, Q, Q_bar);
	D_Flip_Flop_Reset_P7 Master_Slave(D, clk, rst, Q2, Q2_bar);

	initial begin
		know = 0;
		D = 1;
		rst = 0;
		clk = 0;
		# 5;
		clk = 1;
		#10010;
		clk = 1;
		D = 1;
		rst = 0;
		#200;
		clk = 0;
		#200;
		rst = 1;
		#200;
		clk = 1;
		#200;
		clk = 0;
		#200;
		rst = 0;
		clk = 1;
		D = 1;
		#100;
		D = 0;
		#10;
		clk = 0;
		#200;
		D = 1;
		#100;
		clk = 1;
		# 100;
		clk = 0;
		#100;
		clk = 1;
		#90;
		D = 0;
		#10;
		clk = 0;
		#200;
		$stop;
	end
endmodule