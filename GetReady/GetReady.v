`timescale 1ns/1ns
module MyNand (input i1, i2, output o1);
	supply1 Vdd;
	supply0 Gnd;
	pmos #(4,5,6) T1(o1, Vdd, i1), T2(o1, Vdd, i2);
	wire w;
	nmos #(3,4,5) T3(w, Gnd, i1), T4(o1, w, i2);
endmodule 