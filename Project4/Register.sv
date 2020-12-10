`timescale 1ns/1ns

module Register_P8(input clk, rst, [7 : 0]I, output [7 : 0]O);
	wire [7 : 0]ignore;

	genvar i;
	generate
		for (i = 7; i >= 0; i--)
			D_Flip_Flop_Reset_P7 DD(.clk(clk), .rst(rst), .D(I[i]), .Q(O[i]), .Q_bar(ignore[i]));
	endgenerate
endmodule

module Register_TB_P8();
	logic rst, clk;
	logic [7 : 0]D;
	wire [7 : 0]Q;
	logic [20 : 0]know;
	Register_P8 register(clk, rst, D, Q);

	always #1 know++;
	always #50 clk = ~clk;
	always #101 D = $random();
	always #150 if(know > 1000) rst = $random();

	initial begin
		rst = 0;
		clk = 0;
		#10;
		clk = 1;
		D = 8'b0;
		know = 0;
		#3000;
		$stop;
	end
endmodule