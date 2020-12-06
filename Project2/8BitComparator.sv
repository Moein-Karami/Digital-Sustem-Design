`timescale 1ns/1ns

module BCSBasedComparator #(parameter S = 8)(input [S - 1 : 0] a, [S - 1 : 0] b, output EQ, GT);
	wire [S : 0] e, g;
	assign e[S] = 1;
	assign g[S] = 0;
	assign EQ = e[0];
	assign GT = g[0];
	genvar i;
	generate
		for (i = S - 1; i >= 0; i--) begin : Comparator
			GateLevelBCS XX (a[i], b[i], e[i + 1]
					, g[i + 1], e[i], g[i]);
		end
	endgenerate
endmodule

module TCSBasedComparator #(parameter S = 8)(input [S - 1 : 0] a, [S - 1 : 0] b, output EQ, GT);
	parameter n = S / 2;
	wire [n : 0] e, g;
	assign e[n] = 1;
	assign g[n] = 0;
	assign EQ = e[0];
	assign GT = g[0];
	genvar i;
	generate
		for (i = n - 1; i >= 0; i--) begin : Comparator
			TCS XX (a[2 * i + 1 : 2 * i], b[2 * i + 1 : 2 * i], e[i + 1]
					, g[i + 1], e[i], g[i]);
		end
	endgenerate
endmodule