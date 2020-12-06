`timescale 1ns/1ns

module TCS(input [1 : 0]a, [1 : 0]b, eq, gt, output EQ, GT);
	wire a1_bar, b0_bar, gt_bar;
	wire [7 : 0]w;
	
	Inverter inverter1(a[1], a1_bar);
	Inverter inverter2(b[0], b0_bar);
	Inverter inverter3(gt, gt_bar);

	Nand nand1(a1_bar, b[1], w[0]);
	Nor nor1(a[0], b0_bar, w[1]);
	Xnor xnor1(a[1], b[1], w[2]);
	Xnor xnor2(a[0], b[0], w[3]);
	
	Nand nand2(w[1], w[2], w[7]);
	Nand3 nand3_1(eq, w[2], w[3], w[5]);

	Nand nand3(w[0], w[7], w[4]);
	Inverter inverter4(w[5], EQ);

	Nand nand4(eq, w[4], w[6]);

	Nand nand5(gt_bar, w[6], GT);
endmodule 
