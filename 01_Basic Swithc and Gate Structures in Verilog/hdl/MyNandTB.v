`timescale 1ns/1ns

module MyNandTB();
	reg clk, reset;
	reg a, b, expected_w;
	wire w;
	reg [10:0] vector_ind;
	reg [10:0] num_of_errors;
	reg [10:0] num_of_tests;
	reg [2:0] test_vectors[30:0];
	MyNand my_nand(a, b, w);

	initial
	begin 
		vector_ind = 0;
		num_of_errors = 0;
		$readmemb("NandTV.tv", test_vectors);
		num_of_tests = 24;
		reset = 1;
		#100;
		reset = 0;
	end
	
	always
	begin
		clk = 1;
		#50;
		clk = 0;
		#50;
	end

	always @(posedge clk & ~reset)
	begin
		#1;
		{a, b, expected_w} = test_vectors[vector_ind];
	end

	always @(negedge clk & ~reset)
	begin 
		if (w !== expected_w)
		begin 
			num_of_errors = num_of_errors + 1;
			$display("Wrong, Inputs = %b", {a, b});
			$display("Output = %b, Expected: %b", w, expected_w);
		end
		vector_ind = vector_ind + 1;
		if (vector_ind === num_of_tests)
		begin 
			$display("%d tests complited with %d Wrongs", vector_ind, num_of_errors);
			$stop;
		end
	end
endmodule
