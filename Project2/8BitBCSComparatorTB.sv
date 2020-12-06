`timescale 1ns/1ns

module BCSComparatorTB();
	reg clk, reset;
	reg [7 : 0] a, b;
	reg expected_EQ, expected_GT;
	wire EQ, GT;
	reg [20 : 0] vector_ind, errors, tests;
	reg [17 : 0] test_vectors[100000 : 0];
	reg [64:0] now_time;
	reg [64:0] last_clk;
	reg [64:0] EQ_delay_0;
	reg [64:0] EQ_delay_1;
	reg [64:0] GT_delay_0;
	reg [64:0] GT_delay_1;

	BCSBasedComparator #(8) BCSComprator(a, b, EQ, GT);
	
	initial
	begin 
		$readmemb("8BitComparatorTV.tv", test_vectors);
		vector_ind = 0;
		errors = 0;
		tests = 65792;
		reset = 1;
		now_time = 0;
		last_clk = 0;
		EQ_delay_0 = 0;
		EQ_delay_1 = 0;
		GT_delay_0 = 0;
		GT_delay_1 = 0;		
		#600;
		reset = 0;
	end

	always
	begin
		#1;
		now_time = now_time + 1;
	end

	always
	begin
		clk = 1;
		#300;
		clk = 0;
		#300;
		last_clk = last_clk + 600;
	end

	always @(posedge clk & ~reset)
	begin 
		#1;
		{a, b, expected_EQ, expected_GT} = test_vectors[vector_ind];
	end

	always @(negedge EQ)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > EQ_delay_0)
			begin 
				EQ_delay_0 = now_time - last_clk;
			end
		end
	end
	
	always @(posedge EQ)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > EQ_delay_1)
			begin 
				EQ_delay_1 = now_time - last_clk;
			end
		end
	end

	always @(negedge GT)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > GT_delay_0)
			begin 
				GT_delay_0 = now_time - last_clk;
			end
		end
	end

	always @(posedge GT)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > GT_delay_1)
			begin 
				GT_delay_1 = now_time - last_clk;
			end
		end
	end
	
	always @(negedge clk & ~reset)
	begin
		if (EQ !== expected_EQ | expected_GT !== GT)
		begin 
			errors = errors + 1;
			$display("Wrong, Inputs: %b, %b", a, b);
			$display("Outpout: %b, Expected %b", {EQ, GT}, {expected_EQ, expected_GT});
		end
		vector_ind = vector_ind + 1;
		if (vector_ind === tests)
		begin 
			$display("%d tests complited with %d errors", vector_ind, errors);
			$display("EQ worst case delay to1: %d, to0: %d", EQ_delay_1, EQ_delay_0);
			$display("GT worst case delay to1: %d, to0: %d", GT_delay_1, GT_delay_0);

			$stop;
		end
	end
endmodule