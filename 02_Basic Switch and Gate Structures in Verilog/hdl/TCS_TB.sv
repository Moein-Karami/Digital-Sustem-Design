`timescale 1ns/1ns

module TCS_TB();
	reg clk, reset;
	reg [1 : 0]a, b;
	reg eq, gt;
	reg expected_EQ, expected_GT;
	wire EQ, GT;
	reg [10:0] vector_ind, errors, tests;
	reg [7:0] test_vectors[100:0];
	
	TCS tcs(a, b, eq, gt, EQ, GT);
	
	always 
	begin
		clk = 1;
		#100;
		clk =0;
		#100;
	end
	
	initial 
	begin
		$readmemb("TCS_TV.tv", test_vectors);
		tests = 48;
		vector_ind = 0;
		errors = 0;
		reset = 1;
		#200;
		reset =0;
	end
	
	always @(posedge clk & ~reset)
	begin 
		#1;
		{a, b, eq, gt, expected_EQ, expected_GT} = {test_vectors[vector_ind]};
	end

	always @(negedge clk)
	if (~reset)
	begin 
		if (EQ !== expected_EQ || GT !== expected_GT)
		begin
			$display("Wrong: Inputs : a = %b, b = %b, eq = %b, gt = %b", a, b, eq, gt);
			$display("Expected %b_%b, Output = %b_%b", expected_EQ, expected_GT, EQ, GT);
			errors = errors + 1;
		end

		vector_ind = vector_ind + 1;
	
		if ( vector_ind === tests )
		begin 
			$display("%d tests complite with %d wrongs", {vector_ind}, {errors});
			$stop;
		end
	end
endmodule