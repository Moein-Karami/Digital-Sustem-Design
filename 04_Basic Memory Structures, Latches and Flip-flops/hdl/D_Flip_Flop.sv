`timescale 1ns/1ns

module D_Flip_Flop_Reset_P7(input D, clk, rst, output Q, Q_bar);
	wire P, P_bar;
	wire clk_bar, rst_bar;
	wire data;

	assign #4 clk_bar = ~clk;
	assign #4 rst_bar = ~rst;
	assign #12 data = D & rst_bar;

	Clocked_Dlatch_With_Delay_P2 Master(.D(data), .clk(clk), .Q(P), .Q_bar(P_bar));
	Clocked_Dlatch_With_Delay_P2 Slave(.D(P), .clk(clk_bar), .Q(Q), .Q_bar(Q_bar));
endmodule

module D_Flip_Flop_Reset_Always_P9(input D, clk, rst, output logic Q, Q_bar);
	assign Q_bar = ~Q;
	always @(negedge clk)
	begin
		#72 Q <= rst ? 1'b0 : D;
	end
endmodule

module D_Flip_Flop_TB_P7();
	logic clk, D, rst;
	wire Q, Q_bar;
	logic [20]know;

	always #1 know++;
	always #100 if (know < 10000) clk = ~clk;
	always #201 if (know < 10000) D = $random();
	always #430 if (know < 10000) rst = $random();

	D_Flip_Flop_Reset_P7 Master_Slave(D, clk, rst, Q, Q_bar);

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
		D = 1;
		clk = 1;
		#200;
		clk = 0;
		#200;
		clk = 1;
		#8;
		D = 0;
		#200;
		clk = 0;
		#200;
		$stop;
	end
endmodule

module D_Flip_Flop_TB_P9();
	logic clk, D, rst;
	wire Q, Q_bar;
	logic [20]know;

	always #1 know++;
	always #100 if (know < 10000) clk = ~clk;
	always #201 if (know < 10000) D = $random();
	always #430 if (know < 10000) rst = $random();

	D_Flip_Flop_Reset_Always_P9 FlipFlop(D, clk, rst, Q, Q_bar);

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
		$stop;
	end
endmodule