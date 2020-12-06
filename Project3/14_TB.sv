`timescale 1ns/1ns

module Final_TB();
    parameter S = 8;
    logic [S - 1 : 0]reff;
    logic [S - 1 : 0]dataA;
    logic [S-1 : 0]dataB;
    logic [S - 1 : 0]expected_s;
    wire [S - 1 : 0]s;
    logic [S - 1 : 0]s_b;
    logic [S - 1 : 0]diff1;
    logic [S - 1 : 0]diff2;

    logic clk, reset;
    logic [20 : 0] vector_ind, errors, tests;
	logic [31 : 0] test_vectors[100000 : 0];
	logic [64:0] now_time;
	logic [64:0] last_clk;
	logic [64:0] s_delay;

	LessDistance ld(reff, dataA, dataB, s);
	
    always @(reff, dataA, dataB)
    begin
		#837;
        if (reff > dataA)
            assign diff1 = reff - dataA;
        else 
            assign diff1 = dataA - reff;
        if (reff > dataB)
            assign diff2 = reff - dataB;
        else 
            assign diff2 = dataB - reff;
        if (diff1 < diff2)
            assign s_b = dataA;
        else
            assign s_b = dataB;
    end

	initial
	begin 
		$readmemb("LessDistance_TV.tv", test_vectors);
		vector_ind = 0;
		errors = 0;
		tests = 65000;
		reset = 1;
		now_time = 0;
		last_clk = 0;
		s_delay = 0;
		repeat (10) 
		begin
			reff = $random();
			dataA = $random();
			dataB = $random();
			#1600;
			if (s !== s_b)
			begin
				$display("Wrong reff: %b, data_A: %b, data_B: %b, s: %b, s_b: %b", reff, dataA, dataB, s, s_b);
				$stop;
			end
		end
		#(3200);
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
		#(1600);
		clk = 0;
		#(1600);
		last_clk = last_clk + 3200;
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