`timescale 1ns/1ns

module GateLevelBCS(input a1, b1, e0, g0, output e1, g1);
	wire j1_bar, k1_bar, a1_bar, e0_bar, g0_bar;
	xor #12 (j1_bar, a1, b1);
	assign #(5, 7) e0_bar = ~e0;
	nor #(10, 14) (e1, j1_bar, e0_bar);
	assign #(5, 7) a1_bar = ~a1;
	nand #(15, 12) (k1_bar, e0, b1, a1_bar);
	assign #(5, 7) g0_bar = ~g0;
	nand #(10, 8) (g1, k1_bar, g0_bar);
endmodule

