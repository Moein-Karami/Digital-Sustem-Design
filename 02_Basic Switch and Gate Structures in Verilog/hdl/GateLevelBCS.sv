`timescale 1ns/1ns

module GateLevelBCS(input a1, b1, e0, g0, output e1, g1);
	wire j1_bar, k1_bar, a1_bar, e0_bar, g0_bar;
	Xor  xor1(a1, b1, j1_bar);
	Inverter inverter1(e0, e0_bar);
	Nor nor1(j1_bar, e0_bar, e1);
	Inverter inverter2(a1, a1_bar);
	Nand3 nand3_1(e0, b1, a1_bar, k1_bar);
	Inverter inverter3(g0, g0_bar);
	Nand nand1(k1_bar, g0_bar, g1);
endmodule
