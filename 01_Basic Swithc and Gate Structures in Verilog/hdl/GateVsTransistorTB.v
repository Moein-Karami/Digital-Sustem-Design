
`timescale 1ns/1ns

module GateVsTransistorBCSTB();
	reg clk, reset;
	reg a1, b1, e0, g0, expected_e1, expected_g1;
	wire e1, g1;
	wire gate_e1, gate_g1;
	reg [10:0] vector_ind, num_of_errors, num_of_tests;
	reg [6:0] test_vectors[1000:0];
	reg [64:0] e1_worst_case_delay_to_0;
	reg [64:0] e1_worst_case_delay_to_1;
	reg [64:0] g1_worst_case_delay_to_0;
	reg [64:0] g1_worst_case_delay_to_1;
	reg [64:0] gate_e1_worst_case_delay_to_0;
	reg [64:0] gate_e1_worst_case_delay_to_1;
	reg [64:0] gate_g1_worst_case_delay_to_0;
	reg [64:0] gate_g1_worst_case_delay_to_1;
	reg [64:0] now_time;
	reg [64:0] last_clk;

	TransistorLevelBCS transistor_level_BCS(a1, b1, e0, g0, e1, g1);
	GateLevelBCS gate_level_BCS(a1, b1, e0, g0, gate_e1, gate_g1);

	initial
	begin
		$readmemb("TransistorLevelBCSTV.tv", test_vectors);
		vector_ind = 0;
		num_of_errors = 0;
		num_of_tests = 480;
		reset = 1;
		now_time = 0;
		last_clk = 0;
		e1_worst_case_delay_to_0 = 0;
		e1_worst_case_delay_to_1 = 0;
		g1_worst_case_delay_to_0 = 0;
		g1_worst_case_delay_to_1 = 0;
		gate_e1_worst_case_delay_to_0 = 0;
		gate_e1_worst_case_delay_to_1 = 0;
		gate_g1_worst_case_delay_to_0 = 0;
		gate_g1_worst_case_delay_to_1 = 0;
		#100;
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
		#50;
		clk = 0;
		#50;
		last_clk = last_clk + 100;
	end

	always @(posedge clk & ~reset)
	begin 
		#1;
		{a1, b1, e0, g0, expected_e1, expected_g1} = test_vectors[vector_ind];
	end

	always @(negedge e1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > e1_worst_case_delay_to_0)
			begin 
				e1_worst_case_delay_to_0 = now_time - last_clk;
			end
		end
	end
	
	always @(posedge e1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > e1_worst_case_delay_to_1)
			begin 
				e1_worst_case_delay_to_1 = now_time - last_clk;
			end
		end
	end

	always @(negedge g1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > g1_worst_case_delay_to_0)
			begin 
				g1_worst_case_delay_to_0 = now_time - last_clk;
			end
		end
	end

	always @(posedge g1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > g1_worst_case_delay_to_1)
			begin 
				g1_worst_case_delay_to_1 = now_time - last_clk;
			end
		end
	end

	always @(negedge gate_e1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > gate_e1_worst_case_delay_to_0)
			begin 
				gate_e1_worst_case_delay_to_0 = now_time - last_clk;
			end
		end
	end
	
	always @(posedge gate_e1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > gate_e1_worst_case_delay_to_1)
			begin 
				gate_e1_worst_case_delay_to_1 = now_time - last_clk;
			end
		end
	end

	always @(negedge gate_g1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > gate_g1_worst_case_delay_to_0)
			begin 
				gate_g1_worst_case_delay_to_0 = now_time - last_clk;
			end
		end
	end

	always @(posedge gate_g1)
	begin 
		if (now_time > last_clk)
		begin 
			if ((now_time - last_clk) > gate_g1_worst_case_delay_to_1)
			begin 
				gate_g1_worst_case_delay_to_1 = now_time - last_clk;
			end
		end
	end

	always @(negedge clk & ~reset)
	begin
		if (expected_e1 !== e1 | expected_g1 !== g1 | expected_e1 !== gate_e1 | expected_g1 !== gate_g1)
		begin 
			num_of_errors = num_of_errors +1;
			$display("Wrong, Inputs: %b", {a1, b1, e0, g0});
			$display("Outpout: %b, for gates: %b, Expected %b", {e1, g1}, {gate_e1, gate_g1}, {expected_e1, expected_g1});
		end
		vector_ind = vector_ind + 1;
		if (vector_ind === num_of_tests)
		begin 
			$display("%d tests complited with %d errors", vector_ind, num_of_errors);
			$display("e1 worst case delay to0: %d, to1: %d", e1_worst_case_delay_to_0, e1_worst_case_delay_to_1);
			$display("g1 worst case delay to0: %d, to1: %d", g1_worst_case_delay_to_0, g1_worst_case_delay_to_1);
			$display("gate_lavel e1 worst case delay to0: %d, to1: %d", gate_e1_worst_case_delay_to_0, gate_e1_worst_case_delay_to_1);
			$display("gate_lavel g1 worst case delay to0: %d, to1: %d", gate_g1_worst_case_delay_to_0, gate_g1_worst_case_delay_to_1);

			$stop;
		end
	end
endmodule