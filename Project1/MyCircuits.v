`timescale 1ns/1ns

module TransistorLevelBCS(input a1, b1, e0, g0, output e1, g1);
	wire j1_bar, k1_bar, a1_bar, e0_bar, g0_bar;
	MyXor my_xor(a1, b1, j1_bar);
	MyInverter my_inverter1(e0, e0_bar);
	MyNor my_nor (j1_bar, e0_bar, e1);
	MyInverter my_inverter2(a1, a1_bar);
	My3Nand my_3_nand(e0, b1, a1_bar, k1_bar);
	MyInverter my_inverter3(g0, g0_bar);
	MyNand my_nand(k1_bar, g0_bar, g1);
endmodule

module GateLevelBCS(input a1, b1, e0, g0, output e1, g1);
	wire j1_bar, k1_bar, a1_bar, e0_bar, g0_bar;
	XorPrimitive xor_primitive(a1, b1, j1_bar);
	InverterAssign inverter_assign1(e0, e0_bar);
	NorPrimitive nor_primitive (j1_bar, e0_bar, e1);
	InverterAssign inverter_assign2(a1, a1_bar);
	Nand3Primitive nand3_primitive(e0, b1, a1_bar, k1_bar);
	InverterAssign inverter_assign3(g0, g0_bar);
	NandPrimitive nand_primitive(k1_bar, g0_bar, g1);
endmodule