`timescale 1ns/1ns

module MyInverterTB();
	reg clk, reset;
	reg a, w_expected;
	wire w;
	reg [8:0] vector_ind, error_num;
	reg [1:0] test_vectors[10:0];
	MyInverter my_inverter(a, w);

	always
	begin 
		clk = 1;
		#50;
		clk = 0;
		#50;
	end

	initial 
	begin 
		$readmemb("InverterTV.tv", test_vectors);
		vector_ind = 0;
		error_num = 0;
		reset = 1;
		#100;
		reset = 0;
	end

	always @(posedge clk & ~reset)
	begin
		#1;
		{a, w_expected} = {test_vectors[vector_ind]};
	end
	
	always @(negedge clk)
		if (~reset)
		begin
			if (w !== w_expected)
			begin 
				$display("Wrong: input = %b", a);
				$display("Output: = %b, excpected %b", w, w_expected);
				error_num = error_num + 1;
			end
			
			vector_ind = vector_ind + 1;
			if (vector_ind === 3)
			begin 
				$display("%d test complete with %d errors", vector_ind, error_num);
				$stop;
			end
		end
endmodule