`timescale 1ns/1ns

module Controler_TB();
	logic [15 : 0]test_vectors[10005];
	int number_of_tests;
	int test_case;

	logic rst, start, parity, stop_sign;
	logic clk;

	wire ready, cnt_en, cnt_init0, sel_rom, sel_x, reg_x_ld, reg_y_ld, reg_tmp_ld, invert, minus;
	wire reg_res_ld, reg_tmp_init1, reg_res_init1;

	logic exp_ready, exp_cnt_en, exp_cnt_init0, exp_sel_rom, exp_sel_x, exp_reg_x_ld, exp_reg_y_ld, exp_reg_tmp_ld;
	logic exp_invert, exp_minus, exp_reg_res_ld, exp_reg_tmp_init1, exp_reg_res_init1;

	Controler controler(.clk(clk), .rst(rst), .start(start), .parity(parity), .stop_sign(stop_sign), .ready(ready),
			.cnt_en(cnt_en), .cnt_init0(cnt_init0), .sel_rom(sel_rom), .sel_x(sel_x), .reg_x_ld(reg_x_ld),
			.reg_y_ld(reg_y_ld), .reg_tmp_ld(reg_tmp_ld), .invert(invert), .minus(minus), .reg_res_ld(reg_res_ld),
			.reg_tmp_init1(reg_tmp_init1), .reg_res_init1(reg_res_init1));

	initial
	begin
		clk = 0;
		rst = 0;
		test_case = 0;
		number_of_tests = 10000;
		$readmemb("Controler_TV.tv", test_vectors);
	end

	always #100 clk = ~clk;

	always @(negedge clk)
	begin
		#5;
		{start, parity, stop_sign, exp_ready, exp_cnt_en, exp_cnt_init0, exp_sel_rom, exp_sel_x, exp_reg_x_ld,
				exp_reg_y_ld, exp_reg_tmp_ld, exp_invert, exp_minus, exp_reg_res_ld, exp_reg_tmp_init1,
				exp_reg_res_init1} = test_vectors[test_case];
	end

	always @(posedge clk)
	begin
		#50;
		if (exp_ready !== ready || exp_cnt_en !== cnt_en || exp_cnt_init0 !== cnt_init0 || exp_sel_rom !== sel_rom ||
				exp_sel_x !== sel_x || exp_reg_x_ld !== reg_x_ld || exp_reg_y_ld !== reg_y_ld || exp_reg_tmp_ld !==
				reg_tmp_ld || exp_invert !== invert || exp_minus !== minus || exp_reg_res_ld !== reg_res_ld ||
				exp_reg_tmp_init1 !== reg_tmp_init1 || exp_reg_res_init1 !== reg_res_init1)
		begin
			$display("Wrong on test %d", test_case);
			$stop;
		end

		test_case = test_case + 1;

		if (test_case == number_of_tests)
		begin
			$display("accepted on %d test", number_of_tests);
			$stop;
		end
	end
endmodule
