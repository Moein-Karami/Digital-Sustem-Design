`timescale 1ns/1ns

module TB_P2();
	logic SerIn, clk, rst;
	logic expected_outValid, expected_error;
	logic [1 : 0]expected_pn;
	logic [3 : 0]expected_p;
	wire outValid, error;
	wire [1 : 0]pn;
	wire [3 : 0]p;

	MSSD_MS mssd_ms(.clk(clk), .rst(rst), .SerIn(SerIn), .outValid(outValid), .pn(pn),
			.error(error), .p3(p[3]), .p2(p[2]), .p1(p[1]), .p0(p[0]));

	int tests;
	logic [9 : 0]test_vectors[20000 : 0];
	int test_case;

	always #100 clk = ~clk;

	always @ (negedge clk)
	begin
		# 1;
		{SerIn, rst, expected_pn, expected_outValid, expected_p, expected_error} = test_vectors[test_case];
	end

	always @ (posedge clk)
	begin
		# 50;
		if (outValid !== expected_outValid || error !== expected_error)
		begin
			$display("Wrong, Inputs: %b, %b, %b", clk, rst, SerIn);
			$display("Outpouts: %b, Expected %b", {outValid, error, pn, p}, {expected_outValid, expected_error, expected_pn, expected_p});
			$stop;
		end

		if(outValid === 1'b1)
		begin
			if (pn !== expected_pn || p !== expected_p)
			begin
				$display("Wrong, Inputs: %b, %b, %b", clk, rst, SerIn);
				$display("Outpouts: %b, Expected %b", {outValid, error, pn, p}, {expected_outValid, expected_error, expected_pn, expected_p});
				$stop;
			end
		end
		test_case++;
		if (test_case === tests)
		begin 
			$display("%d tests complited without any error", test_case);
			$stop;
		end
	end

	initial
	begin
		$readmemb("TestVectors.tv", test_vectors);
		tests = 17309;
		#20;
		clk = 0;
	end
endmodule