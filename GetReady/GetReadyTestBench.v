`timescale 1ns/1ns
module MyNandTestBench();
	reg a, b;
	wire w;
	MyNand tmp(a, b, w);
	//always #13 a = ~a ;
	repeat (20) #13 a = ~a;
	initial begin 
	#1 a=0;
	#1 b=0;
	#10000 $stop;
	end
	always #29 b = ~b;
endmodule	