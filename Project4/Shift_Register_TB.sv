`timescale 1ns/1ns

module Shift_Register_TB_P6();
	logic sIn, clk, rst;
	wire sOut;

	Shift_Register_P5 shift_register(.sIn(sIn), .clk(clk), .rst(rst), .sOut(sOut));

	always #600 clk = ~clk;
	always #1205 sIn = $random();

	initial begin
		clk = 1;
		#100;
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

module Shift_Register_TB_P8();
	logic sIn, clk, rst;
	wire sOut;

	Shift_Register_P8 shift_register(.sIn(sIn), .clk(clk), .rst(rst), .sOut(sOut));

	always #600 clk = ~clk;
	always #1205 sIn = $random();

	initial begin
		clk = 1;
		sIn = $random();
		rst = 0;
		#100;
		clk = 0;
		#20000;
		rst = 1;
		#2000;
		rst = 0;
		#4000;
		rst = 1;
		#4000;
		$stop;
	end
endmodule

module Shift_Register_TB_P10();
	logic sIn, clk, rst;
	wire sOut;

	Shift_Register_P10 shift_register(.sIn(sIn), .clk(clk), .rst(rst), .sOut(sOut));

	always #600 clk = ~clk;
	always #1215 sIn = $random();

	initial begin
		clk = 1;
		sIn = $random();
		rst = 0;
		#20000;
		rst = 1;
		#2000;
		rst = 0;
		#4000;
		rst = 1;
		#4000;
		$stop;
	end
endmodule

module Final_Shift_Register_TB_P10();
	logic sIn, clk, rst;
	wire sOut1, sOut2;
	logic [20] know;

	Shift_Register_P10 shift_register10(.sIn(sIn), .clk(clk), .rst(rst), .sOut(sOut1));
	Shift_Register_P8 shift_register8(.sIn(sIn), .clk(clk), .rst(rst), .sOut(sOut2));

	always #1 know++;
	always #600 if (know < 45000) clk = ~clk;
	always #1205 if (know < 30000) sIn = $random();

	always #1200
	begin
		if (know >= 43000 && know <= 70000)
		begin
			clk = 1;
			sIn = 1;
			#590;
			sIn = 0;
			#10;
			clk = 0;
			#600;
		end
	end

	always #1200
	begin
		if (know >= 70000)
		begin
			clk = 1;
			sIn = 0;
			#590;
			sIn = 1;
			#10;
			clk = 0;
			#600;
		end
	end

	initial begin
		know = 0;
		clk = 1;
		sIn = $random();
		rst = 0;
		#20000;
		rst = 1;
		#2000;
		rst = 0;
		#4000;
		rst = 1;
		#4000;
		rst = 0;
		sIn = 1;
		#10190;
		rst = 1;
		#3000;
		rst = 0;
		#70000;
		$stop;
	end
endmodule