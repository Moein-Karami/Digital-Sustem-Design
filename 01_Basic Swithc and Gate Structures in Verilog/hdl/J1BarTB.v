`timescale 1ns/1ns

module J1BarTB();
	reg clk, reset;
	reg a1, b1, expected_j1_bar;
	wire j1_bar;
	reg [10:0] vector_ind, num_of_errors;
	reg [2:0] test_vectors[30:0];
	
	MyXor my_xor(a1, b1, j1_bar);
	
	always 
	begin
		clk = 1;
		#50;
		clk =0;
		#50;
	end
	
	initial 
	begin
		$readmemb("J1BarTv.tv", test_vectors);
		vector_ind = 0;
		num_of_errors = 0;
		reset = 1;
		#100;
		reset =0;
	end
	
	always @(posedge clk & ~reset)
	begin 
		#1;
		{a1, b1, expected_j1_bar} = {test_vectors[vector_ind]};
	end

	always @(negedge clk)
	if (~reset)
	begin 
		if (j1_bar !== expected_j1_bar)
		begin
			$display("Wrong: Inputs = %b", {a1, b1});
			$display("Expected %b, Output = %b", expected_j1_bar, j1_bar);
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