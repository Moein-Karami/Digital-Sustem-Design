module Cosinus(input clk, rst, start, input [9 : 0]x, input [7 : 0]y, output ready, output [9 : 0]result);
	wire parity, cnt_en, cnt_init0, sel_rom, sel_x, reg_x_ld, reg_y_ld, reg_tmp_ld, stop_sign;
	wire invert, minus, reg_res_ld, reg_tmp_init1, reg_res_init1;

	Controler controler(.clk(clk), .rst(rst), .start(start), .ready(ready), .parity(parity), .cnt_en(cnt_en),
			.cnt_init0(cnt_init0), .sel_rom(sel_rom), .sel_x(sel_x), .reg_x_ld(reg_x_ld), .reg_y_ld(reg_y_ld),
			.reg_tmp_ld(reg_tmp_ld), .stop_sign(stop_sign), .invert(invert), .minus(minus), .reg_res_ld(reg_res_ld),
			.reg_tmp_init1(reg_tmp_init1), .reg_res_init1(reg_res_init1));

	DataPath data_path(.clk(clk), .rst(rst), .parity(parity), .cnt_en(cnt_en), .x(x), .y(y), .result(result),
			.cnt_init0(cnt_init0), .sel_rom(sel_rom), .sel_x(sel_x), .reg_x_ld(reg_x_ld), .reg_y_ld(reg_y_ld),
			.reg_tmp_ld(reg_tmp_ld), .stop_sign(stop_sign), .invert(invert), .minus(minus), .reg_res_ld(reg_res_ld),
			.reg_tmp_init1(reg_tmp_init1), .reg_res_init1(reg_res_init1));
endmodule