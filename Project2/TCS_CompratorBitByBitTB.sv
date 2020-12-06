`timescale 1ns/1ns

module TCS_ComparatorBitByBitTB();
	reg clk, reset;
	reg [7 : 0] a, b;
	reg [7 : 0] last_a, last_b;
	reg expected_EQ, expected_GT;
	wire EQ, GT;
	reg [20 : 0] vector_ind, errors, tests;
	reg [17 : 0] test_vectors[200000 : 0];
	reg [64:0] now_time;
	reg [64:0] last_clk;
	reg [64:0] EQ_delay_0;
	reg [64:0] EQ_delay_1;
	reg [64:0] GT_delay_0;
	reg [64:0] GT_delay_1;
	reg [64:0] a_delay_eq[1000:0];
	reg [64:0] b_delay_eq[1000:0];
	reg [64:0] a_delay_gt[1000:0];
	reg [64:0] b_delay_gt[1000:0];

	TCSBasedComparator #(8) BCSComprator(a, b, EQ, GT);
	
	initial
	begin
		for (int i = 0; i < 1000; i++)
		begin 
			a_delay_eq[i] = 0;
			b_delay_eq[i] = 0;
			a_delay_gt[i] = 0;
			b_delay_gt[i] = 0;
		end
		a = 0;
		b = 0;
		$readmemb("BitByBit.tv", test_vectors);
		vector_ind = 0;
		errors = 0;
		tests = 131586;
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
		last_a = a;
		last_b = b;
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
			if( last_a > a)
			begin
				if ((now_time - last_clk) > a_delay_eq[last_a - a])
				begin 
					a_delay_eq[last_a - a] = now_time - last_clk;
				end
			end
			if( last_b > b)
			begin
				if ((now_time - last_clk) > b_delay_eq[last_b - b])
				begin 
					b_delay_eq[last_b - b] = now_time - last_clk;
				end
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

			if( last_a > a)
			begin
				if ((now_time - last_clk) > a_delay_eq[last_a - a])
				begin 
					a_delay_eq[last_a - a] = now_time - last_clk;
				end
			end
			if( last_b > b)
			begin
				if ((now_time - last_clk) > b_delay_eq[last_b - b])
				begin 
					b_delay_eq[last_b - b] = now_time - last_clk;
				end
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

			if( last_a > a)
			begin
				if ((now_time - last_clk) > a_delay_gt[last_a - a])
				begin 
					a_delay_gt[last_a - a] = now_time - last_clk;
				end
			end
			if( last_b > b)
			begin
				if ((now_time - last_clk) > b_delay_gt[last_b - b])
				begin 
					b_delay_gt[last_b - b] = now_time - last_clk;
				end
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

			if( last_a > a)
			begin
				if ((now_time - last_clk) > a_delay_gt[last_a - a])
				begin 
					a_delay_gt[last_a - a] = now_time - last_clk;
				end
			end
			if( last_b > b)
			begin
				if ((now_time - last_clk) > b_delay_gt[last_b - b])
				begin 
					b_delay_gt[last_b - b] = now_time - last_clk;
				end
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
			
			$display("EQ worst case delay for a bits from 1 to 0: %d, %d, %d, %d, %d, %d, %d, %d",
					a_delay_eq[128], a_delay_eq[64], a_delay_eq[32], a_delay_eq[16], 
					a_delay_eq[8], a_delay_eq[4], a_delay_eq[2], a_delay_eq[1]);
			$display("EQ worst case delay for b bits from 1 to 0: %d, %d, %d, %d, %d, %d, %d, %d",
					b_delay_eq[128], b_delay_eq[64], b_delay_eq[32], b_delay_eq[16], 
					b_delay_eq[8], b_delay_eq[4], b_delay_eq[2], b_delay_eq[1]); 
			$display("GT worst case delay for a bits from 1 to 0: %d, %d, %d, %d, %d, %d, %d, %d",
					a_delay_gt[128], a_delay_gt[64], a_delay_gt[32], a_delay_gt[16], 
					a_delay_gt[8], a_delay_gt[4], a_delay_gt[2], a_delay_gt[1]);
			$display("GT worst case delay for b bits from 1 to 0: %d, %d, %d, %d, %d, %d, %d, %d",
					b_delay_gt[128], b_delay_gt[64], b_delay_gt[32], b_delay_gt[16], 
					b_delay_gt[8], b_delay_gt[4], b_delay_gt[2], b_delay_gt[1]); 
			$stop;
		end
	end
endmodule