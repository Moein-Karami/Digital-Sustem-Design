`timescale 1ns/1ns

module XorPrimitive(input a, b, output w);
	xor #12 (w, a, b);
endmodule

module InverterAssign(input a, output a_bar);
	assign #(5, 7) a_bar = ~a;
endmodule

module NorPrimitive(input a, b, output w);
	nor #(10, 14) (w, a, b);
endmodule 

module NandPrimitive(input a, b, output w);
	nand #(10, 8) (w, a, b);
endmodule

module Nand3Primitive(input a, b, c, output w);
	nand #(15, 12) (w, a, b, c);
endmodule

