`timescale 1ns/1ns

module MyXorTB();
	reg clk, reset;
	reg a, b, expected_w;
	wire w;
	reg [10:0] vector_ind, num_of_errors;
	reg [2:0] test_vectors[30:0];
	
	MyXor my_xor(a, b, w);
	
	always 
	begin
		clk = 1;
		#50;
		clk =0;
		#50;
	end
	
	initial 
	begin
		$readmemb("XorTV.tv", test_vectors);
		vector_ind = 0;
		num_of_errors = 0;
		reset = 1;
		#100;
		reset =0;
	end
	
	always @(posedge clk & ~reset)
	begin 
		#1;
		{a, b, expected_w} = {test_vectors[vector_ind]};
	end

	always @(negedge clk)
	if (~reset)
	begin 
		if (w !== expected_w)
		begin
			$display("Wrong: Inputs = %b", {a, b});
			$display("Expected %b, Output = %b", expected_w, w);
			num_of_errors = num_of_errors + 1;
		end

		vector_ind = vector_ind + 1;
	
		if ( vector_ind === 24 )
		begin 
			$display("%d tests complite with %d wrongs", {vector_ind}, {num_of_errors});
			$stop;
		end
	end
endmodule
