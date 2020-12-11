`timescale 1ns/1ns

module Shift_Register_P5(input sIn, clk, rst, output sOut);
	wire [8 : 0]Q;
	wire [7 : 0]ignore;

	assign Q[8] = sIn;
	assign sOut = Q[0];

	genvar i;
	generate
		for (i = 7; i >=0; i--)
			Clocked_Dlatch_With_Delay_Reset_P4 DD(.D(Q[i + 1]), .clk(clk), .rst(rst), .Q(Q[i]), .Q_bar(ignore[i]));
	endgenerate
endmodule

module Shift_Register_P8(input sIn, clk, rst, sOut);
	wire [8 : 0]Q;
	wire [7 : 0]ignore;

	assign Q[8] = sIn;
	assign sOut = Q[0];

	genvar i;
	generate
		for (i = 7; i >=0; i--)
			 D_Flip_Flop_Reset_P7 DD(.D(Q[i + 1]), .clk(clk), .rst(rst), .Q(Q[i]), .Q_bar(ignore[i]));
	endgenerate
endmodule

module Shift_Register_P10(input sIn, clk, rst, sOut);
	wire [8 : 0]Q;
	wire [7 : 0]ignore;

	assign Q[8] = sIn;
	assign sOut = Q[0];

	genvar i;
	generate
		for (i = 7; i >=0; i--)
			 D_Flip_Flop_Reset_Always_P9 DD(.D(Q[i + 1]), .clk(clk), .rst(rst), .Q(Q[i]), .Q_bar(ignore[i]));
	endgenerate
endmodule