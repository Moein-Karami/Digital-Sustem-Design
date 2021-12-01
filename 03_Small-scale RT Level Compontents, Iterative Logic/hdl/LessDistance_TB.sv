`timescale 1ns/1ns
//assertion
module LessDistance_TB();
    parameter S = 8;
    logic [S - 1 : 0]reff;
    logic [S - 1 : 0]dataA;
    logic [S-1 : 0]dataB;
    logic [S - 1 : 0]expected_s;
    wire [S - 1 : 0]s;

    logic clk, reset;
    logic [20 : 0] vector_ind, errors, tests;
	logic [31 : 0] test_vectors[100000 : 0];
	logic [64:0] now_time;
	logic [64:0] last_clk;
	logic [64:0] s_delay;

	LessDistance ld(reff, dataA, dataB, s);
	
	initial
	begin 
		$readmemb("LessDistance_TV.tv", test_vectors);
		vector_ind = 0;
		errors = 0;
		tests = 650;
		reset = 1;
		now_time = 0;
		last_clk = 0;
		s_delay = 0;	
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
		{reff, dataA, dataB, expected_s} = test_vectors[vector_ind];
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
		if (s !== expected_s)
		begin 
			errors = errors + 1;
			$display("Wrong, Inputs: %b, %b, %b", reff, dataA, dataB);
			$display("Outpout: %b, Expected %b", s, expected_s);
		end
		vector_ind = vector_ind + 1;
		if (vector_ind === tests)
		begin 
			$display("%d tests complited with %d errors", vector_ind, errors);
			$display("s worst case delay: %d", s_delay);

			$stop;
		end
	end
endmodule