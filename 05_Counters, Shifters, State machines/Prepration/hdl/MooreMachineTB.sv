`timescale 1ns/1ns

module MooreMachine1011TB_P2();
	logic rst, clk, in;
	wire out1, out2;

	always #100 if ($time <= 10000) clk = ~clk;
	always #200 if ($time <= 10000) in = $random();

	MooreMachine1011 moore_machin1011(.clk(clk), .rst(rst), .in(in), .out(out1));
	MooreMachine moore_machin(.clk(clk), .rst(rst), .in(in), .out(out2));

	initial begin
		in = 0;
		clk = 0;
		rst = 0;
		#10001;
		in = 1;
		#100;
		clk = 1;
		#100;
		clk = 0;
		#100;
		in = 0;
		#100;
		clk = 1;
		rst = 1;
		#100;
		clk = 0;
		rst = 0;
		#100;
		in = 1;
		#100;
		clk = 1;
		#100;
		clk = 0;
		#100;
		in = 1;
		#100;
		clk = 1;
		#100;
		clk = 0;
		#100;
		$stop;
	end
endmodule