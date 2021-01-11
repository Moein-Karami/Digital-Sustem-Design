module Controler(input clk, rst, start, parity, stop_sign, output ready, cnt_en, cnt_init0, sel_rom, sel_x, reg_x_ld, reg_y_ld,
		reg_tmp_ld, invert, minus, reg_res_ld, reg_tmp_init1, reg_res_init1);
	logic [2 : 0]ps;
	logic [2 : 0]ns;

	parameter [2 : 0]Idle = 3'b000;
	parameter [2 : 0]Init = 3'b001;
	parameter [2 : 0]Loud = 3'b010;
	parameter [2 : 0]xMul = 3'b011;
	parameter [2 : 0]romMul = 3'b100;
	parameter [2 : 0]Add = 3'b101;

	always @(ps, start, stop_sign, parity)
	begin
		ns = Idle;
		case (ps)
			Idle : ns = start ? Init : Idle;
			Init : ns = start ? Init : Loud;
			Loud : ns = xMul;
			xMul : ns = romMul;
			romMul : ns = Add;
			Add : ns = stop_sign ? Idle : xMul;
			default : ns = Idle;
		endcase
	end


	assign ready = (ps === Idle) ? 1'b1 : 1'b0;
	assign cnt_init0 = (ps === Init) ? 1'b1 : 1'b0;
	assign reg_tmp_init1 = (ps === Init) ? 1'b1 : 1'b0;
	assign reg_res_init1 = (ps === Init) ? 1'b1 : 1'b0;
	assign reg_x_ld = (ps === Loud) ? 1'b1 : 1'b0;
	assign reg_y_ld = (ps === Loud) ? 1'b1 : 1'b0;
	assign sel_x = (ps === xMul) ? 1'b1 : 1'b0;
	assign reg_tmp_ld = (ps === xMul || ps ===romMul) ? 1'b1 : 1'b0;
	assign sel_rom = (ps === romMul) ? 1'b1 : 1'b0;
	assign cnt_en = (ps === Add) ? 1'b1 : 1'b0;
	assign invert = (ps === Add) ? ~parity : 1'b0;
	assign minus = (ps === Add) ? ~parity : 1'b0;
	assign reg_res_ld = (ps === Add) ? 1'b1 : 1'b0;

	always @(posedge clk, posedge rst)
	begin
		if (rst === 1'b1)
			ps <= Idle;
		else
			ps <= ns;
	end
endmodule