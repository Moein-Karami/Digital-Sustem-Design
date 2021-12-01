`timescale 1ns/1ns

module CompareTB();
	reg clk, reset;
	reg [7 : 0] a, b;
	reg expected_EQ, expected_GT;
	wire BCS_EQ, BCS_GT;
	wire TCS_EQ, TCS_GT;
	reg [20 : 0] vector_ind, errors, tests;
	reg [17 : 0] test_vectors[200000 : 0];

	BCSBasedComparator #(8) BCSComprator(a, b, BCS_EQ, BCS_GT);
	TCSBasedComparator #(8) TCSComprator(a, b, TCS_EQ, TCS_GT);

	initial
	begin 
		$readmemb("BitByBit.tv", test_vectors);
		vector_ind = 0;
		errors = 0;
		tests = 131586;
		reset = 1;
		#600;
		reset = 0;
	end

	always
	begin
		clk = 1;
		#300;
		clk = 0;
		#300;
	end

	always @(posedge clk & ~reset)
	begin 
		#1;
		{a, b, expected_EQ, expected_GT} = test_vectors[vector_ind];
	end

	
	always @(negedge clk & ~reset)
	begin
		if (BCS_EQ !== expected_EQ | expected_GT !== BCS_GT | TCS_GT !== BCS_GT | TCS_EQ !== BCS_EQ)
		begin 
			errors = errors + 1;
			$display("Wrong, Inputs: %b, %b", a, b);
			$display("Outpout: BCS: %b, TCS: %b, Expected %b", {BCS_EQ, BCS_GT}, {TCS_EQ, TCS_GT}, {expected_EQ, expected_GT});
		end
		vector_ind = vector_ind + 1;
		if (vector_ind === tests)
		begin 
			$display("%d tests complited with %d errors", vector_ind, errors);
			$stop;
		end
	end
endmodule