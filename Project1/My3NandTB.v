`timescale 1ns/1ns

module My3NandTB();
	reg clk, reset;
	reg a, b, c, expected_w;
	wire w;
	reg [10:0] vector_ind, num_of_errors, num_of_tests;
	reg [3:0] test_vectors[1000:0];
	My3Nand my_3_nand(a, b, c, w);

	initial
	begin
		$readmemb("Nand3TV.tv", test_vectors);
		vector_ind = 0;
		num_of_errors = 0;
		num_of_tests = 112;
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
		{a, b, c, expected_w} = test_vectors[vector_ind];
	end

	always @(negedge clk & ~reset)
	begin
		if (expected_w !== w)
		begin 
			num_of_errors = num_of_errors +1;
			$display("Wrong, Inputs: %b", {a, b, c});
			$display("Outpout: %b, Expected %b", w, expected_w);
		end
		vector_ind = vector_ind + 1;
		if (vector_ind === num_of_tests)
		begin 
			$display("%d tests complited with %d errors", vector_ind, num_of_errors);
			$stop;
		end
	end
endmodule