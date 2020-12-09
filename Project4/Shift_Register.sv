`timescale 1ns/1ns

module Shigt_Register_P5(input sIn, clk, rst, output sOut);
	wire [8 : 0]Q;
	
	assign Q[8] = sIn;
	assign sOut = Q[0];

	genvar i;
	generate
		for (i = 7; i >=0; i--)
			Clocked_Dlatch_With_Delay_Reset_P4 DD(.D(Q[i + 1]), .clk(clk), .rst(rst), .Q(Q[i]));
	endgenerate
endmodule