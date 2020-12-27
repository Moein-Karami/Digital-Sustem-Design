
`timescale 1ns/1ps

module TB_QC_P6();
	logic SerIn, clk, rst;
	logic expected_outValid, expected_error;
	logic [1 : 0]expected_pn;
	
	logic [3 : 0]expected_p;
	wire outValid_ms, error_ms;
	wire [1 : 0]pn_ms;
	wire [3 : 0]p_ms;

	wire outValid_qc, error_qc;
	wire [1 : 0]pn_qc;
	wire [3 : 0]p_qc;

	MSSD_MS mssd_ms(.clk(clk), .rst(rst), .SerIn(SerIn), .outValid(outValid_ms), .pn(pn_ms),
			.error(error_ms), .p3(p_ms[3]), .p2(p_ms[2]), .p1(p_ms[1]), .p0(p_ms[0]));
	MSSD_QC mssd_qc(.clk(clk), .rst(rst), .SerIn(SerIn), .outValid(outValid_qc), .pn(pn_qc),
			.error(error_qc), .p3(p_qc[3]), .p2(p_qc[2]), .p1(p_qc[1]), .p0(p_qc[0]));

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
		if (outValid_ms !== expected_outValid || error_ms !== expected_error ||
				outValid_qc !== expected_outValid || error_qc !== expected_error)
		begin
			$display("Wrong, Inputs: %b, %b, %b", clk, rst, SerIn);
			$display("Outpouts: %b, Expected %b", {outValid_ms, error_ms, pn_ms, p_ms}, {expected_outValid, expected_error, expected_pn, expected_p});
			$stop;
		end

		if(outValid_ms === 1'b1)
		begin
			if (pn_ms !== expected_pn || p_ms !== expected_p || pn_qc !== expected_pn || p_qc !== expected_p)
			begin
				$display("Wrong, Inputs: %b, %b, %b", clk, rst, SerIn);
				$display("Outpouts: %b, Expected %b", {outValid_ms, error_ms, pn_ms, p_ms}, {expected_outValid, expected_error, expected_pn, expected_p});
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