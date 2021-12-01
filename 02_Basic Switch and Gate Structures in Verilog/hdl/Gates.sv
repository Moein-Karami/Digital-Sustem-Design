`timescale 1ns/1ns

module Nand(input a, b, output w);
	assign #(10, 8) w = ~(a & b);
endmodule

module Xor(input a, b, output w);
	assign #12 w = a ^ b;
endmodule

module Inverter(input a, output w);
	assign #(5, 7) w = ~a;
endmodule

module Nor(input a, b, output w);
	assign #(10, 14) w = ~(a | b);
endmodule

module Nand3(input a, b, c, output w);
	assign #(15, 12) w = ~(a & b & c);
endmodule

module Xnor(input a, b, output w);
	assign #(14, 14) w = ~(a ^ b);
endmodule