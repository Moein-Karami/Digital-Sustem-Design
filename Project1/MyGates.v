`timescale 1ns/1ns

module MyInverter(input i, output o);
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5, 6, 7) p(o, Vdd, i);
	nmos #(3, 4, 5) n(o, Gnd, i);
endmodule

module MyXor(input a, b, output w);
	wire a_bar, b_bar;
	MyInverter inverter1(a, a_bar), inverter2(b, b_bar);
	nmos #(3, 4, 5) n1(w, a_bar, b);
	nmos #(3, 4, 5) n2(w, a, b_bar);
endmodule

module MyNor(input a, b, output w);
	wire tmp;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5, 6, 7) p1(tmp, Vdd, a), p2(w, tmp, b);
	nmos #(3, 4, 5) n1(w, Gnd, a), n2(w, Gnd, b);
endmodule

module MyNand(input a, b, output w);
	wire tmp;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5, 6, 7) p1(w, Vdd, a), p2(w, Vdd, b);
	nmos #(3, 4, 5) n1(tmp, Gnd, b), n2(w, tmp, a);
endmodule

module My3Nand(input a, b ,c, output w);
	wire tmp1, tmp2;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5, 6, 7) p1(w, Vdd, a), p2(w, Vdd, b), p3(w, Vdd, c);
	nmos #(3, 4, 5) n1(tmp1, Gnd, c), n2(tmp2, tmp1, a), n3(w, tmp2, b);
endmodule