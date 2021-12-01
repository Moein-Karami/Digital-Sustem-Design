`timescale 1ns/1ns

module Clocked_Dlatch_P1(input D, clk, output Q, Q_bar);
	wire w1, w2;

	nand n1(w1, D, clk);
	nand n2(w2, clk, w1);
	nand n3(Q, w1, Q_bar);
	nand n4(Q_bar, w2, Q);
endmodule

module Clocked_Dlatch_With_Delay_P2(input D, clk, output Q, Q_bar);
	wire w1, w2, w3, w4, rst_bar;
	
	nand #8 n1(w1, D, clk);
	nand #8 n2(w2, clk, w1);
	
	nand #8 n3(Q, w1, Q_bar);
	nand #8 n4(Q_bar, w2, Q);
endmodule

module Clocked_Dlatch_With_Delay_Reset_P4(input D, clk, rst, output Q, Q_bar);
	wire w1, w2;

	nand #8 n1(w1, D, clk, ~rst);
	nand #8 n2(w2, clk, w1);

	assign #16 w3 = w1 | rst;
	assign #4 rst_bar = ~rst;
	assign #12 w4 = rst_bar & w2; 

	nand #8 n3(Q, w3, Q_bar);
	nand #8 n4(Q_bar, w4, Q);
endmodule