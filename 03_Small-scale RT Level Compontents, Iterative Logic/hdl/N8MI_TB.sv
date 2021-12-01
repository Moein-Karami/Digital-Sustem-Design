`timescale 1ns/1ns

module N8MI_TB();
    parameter S = 8;
    logic [S - 1 : 0]a;
    logic [S - 1 : 0]expected_s;
    wire [S - 1 : 0]s;
    wire carry_out;
    logic expected_carry_out;
    logic clk, reset;
    logic [20 : 0] vector_ind, errors, tests;
	logic [16 : 0] test_vectors[100000 : 0];
	logic [64:0] now_time;
	logic [64:0] last_clk;
	logic [64:0] s_delay;
	logic [64:0] carry_out_delay_0;
	logic [64:0] carry_out_delay_1;

	NMI_using_TMI #8 incrementor(a, s, carry_out);
	
	initial
	begin 
		$readmemb("8bit_incrementor_TV.tv", test_vectors);
		vector_ind = 0;
		errors = 0;
		tests = 256;
		reset = 1;
		now_time = 0;
		last_clk = 0;
		s_delay = 0;
		carry_out_delay_0 = 0;
		carry_out_delay_1 = 0;	
		#(1600);
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
		#(800);
		clk = 0;
		#(800);
		last_clk = last_clk + 1600;
	end

	always @(posedge clk & ~reset)
	begin 
		#1;
		{a, expected_carry_out, expected_s} = test_vectors[vector_ind];
	end

	always @(negedge carry_out)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > carry_out_delay_0)
			begin 
				carry_out_delay_0 = now_time - last_clk;
			end
		end
	end
	
	always @(posedge carry_out)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > carry_out_delay_1)
			begin 
				carry_out_delay_1 = now_time - last_clk;
			end
		end
	end

    always @(s)
    begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > s_delay)
			begin 
				s_delay = now_time - last_clk;
			end
		end
	end
	
	always @(negedge clk & ~reset)
	begin
		if (s !== expected_s | expected_carry_out !== carry_out)
		begin 
			errors = errors + 1;
			$display("Wrong, Inputs: %b", a);
			$display("Outpout: %b, Expected %b", {carry_out, s}, {expected_carry_out, expected_s});
		end
		vector_ind = vector_ind + 1;
		if (vector_ind === tests)
		begin 
			$display("%d tests complited with %d errors", vector_ind, errors);
			$display("carry_out worst case delay to1: %d, to0: %d", carry_out_delay_1, carry_out_delay_0);
			$display("s worst case delay: %d", s_delay);

			$stop;
		end
	end
endmodule