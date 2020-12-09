`timescale 1ns/1ns

module Clocked_Dlatch_P1(input D, clk, output Q, Q_bar);
	wire w1, w2;

	nand n1(w1, D, clk);
	nand n2(w2, clk, w1);
	nand n3(Q, w1, Q_bar);
	nand n4(Q_bar, w2, Q);
endmodule

module Clocked_Dlatch_With_Delay_P2(input D, clk, output Q, Q_bar);
	wire w1, w2;

	nand #8 n1(w1, D, clk);
	nand #8 n2(w2, clk, w1);
	nand #8 n3(Q, w1, Q_bar);
	nand #8 n4(Q_bar, w2, Q);
endmodule

module Clocked_Dlatch_With_Delay_Reset_P4(input D, clk, rst, output Q, Q_bar);
	wire w1, w2;

	nand #8 n1(w1, D, clk, ~rst);
	nand #8 n2(w2, clk, w1);
	nand #8 n3(Q, w1, Q_bar);
	nand #8 n4(Q_bar, w2, Q);
endmodule