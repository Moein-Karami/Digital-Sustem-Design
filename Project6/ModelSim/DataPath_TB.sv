`timescale 1ns/1ns

module Controler_TB();
	wire [17 : 0]test_vectors[100000];
	int number_of_test;
	int test_case;

	wire clk, rst, start, parity, stop_sign;

	wire ready, cnt_en, cnt_init0, sel_rom, sel_x, reg_x_ld, reg_y_ld, reg_tmp_ld, invert, minus;
	wire reg_res_ld, reg_tmp_init1, reg_res_init1;

	wire exp_ready, exp_cnt_en, exp_cnt_init0, exp_sel_rom, exp_sel_x, exp_reg_x_ld, exp_reg_y_ld, exp_reg_tmp_ld;
	wire exp_invert, exp_minus, exp_reg_res_ld, exp_reg_tmp_init1, exp_reg_res_init1;
