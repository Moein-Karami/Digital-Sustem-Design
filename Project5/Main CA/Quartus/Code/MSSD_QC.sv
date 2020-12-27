`timescale 1ns/1ns

module MSSD_QC(input clk, SerIn, rst, output [1 : 0]pn, output outValid, p3, p2, p1, p0, error);
	wire up_counter3_carry_out, up_counter9_carry_out, up_counter3_rst, finish_signal;
	wire up_counter3_enable, shift_register_enable, up_counter9_enable, fixer_carry_out, up_counter9_loud;
	wire [7 : 0]shift_register_output;
	wire [5 : 0]up_counter9_input;

	StateMachine_QC state_machine_qc(.clk(clk), .rst(rst), .SerIn(SerIn), .up_counter3_carry_out(up_counter3_carry_out),
			.finish_signal(finish_signal), .up_counter3_enable(up_counter3_enable), .up_counter9_loud(up_counter9_loud),
			.up_counter3_rst(up_counter3_rst), .shift_register_enable(shift_register_enable),
			.error_flag(error), .valid_output(outValid), .up_counter9_enable(up_counter9_enable));
	
	UpCounter3Bit_QC up_counter_3bit_qc(.clk(clk), .rst(up_counter3_rst), .enable(up_counter3_enable),
			.carry_out(up_counter3_carry_out));

	ShiftRegister_QC shift_register_qc(.clk(clk), .SerIn(SerIn), .enable(shift_register_enable),
			.out(shift_register_output));

	Fixer_QC fixer_qc(.in(shift_register_output[7 : 2]), .out(up_counter9_input), .carry_out(fixer_carry_out));

	UpCounter9Bit_QC up_counter_9bit_qc(.clk(clk), .loud(up_counter9_loud), .enable(up_counter9_enable),
			.carry_out(up_counter9_carry_out), .in({up_counter9_input, 1'b0, 1'b0, 1'b1}));

	Decoder_QC decoder_qc(.in(SerIn), .position(shift_register_output[1 : 0]), .out({p3, p2, p1, p0}));

	assign finish_signal = up_counter9_carry_out | fixer_carry_out;
	assign pn = shift_register_output[1 : 0];
endmodule

module StateMachine_QC(input clk, rst, SerIn, up_counter3_carry_out, finish_signal,
		output up_counter3_rst, up_counter3_enable, shift_register_enable, error_flag,
		valid_output, up_counter9_enable, up_counter9_loud);
	
	logic [2 : 0]curr_state;
	logic [2 : 0]next_state;

	parameter [2 : 0] start = 3'b000;
	parameter [2 : 0] get_info = 3'b001;
	parameter [2 : 0] get_data = 3'b010;
	parameter [2 : 0] finish = 3'b011;
	parameter [2 : 0] error = 3'b100;
	parameter [2 : 0] get_first_data = 3'b101;

	always @ (curr_state, SerIn, up_counter3_carry_out, finish_signal)
	begin
		case (curr_state)
			start : next_state = SerIn ? start : get_info;
			get_info : next_state = up_counter3_carry_out ? get_first_data : get_info;
			get_data : next_state = finish_signal ? finish : get_data;
			finish : next_state = SerIn ? start : error;
			error : next_state = SerIn ? start : error;
			get_first_data : next_state = finish_signal ? finish : get_data;
			default : next_state = start;
		endcase
	end

	assign up_counter3_rst = (curr_state === start) ? 1'b1 : 1'b0;
	assign up_counter3_enable = (curr_state === get_info) ? 1'b1 : 1'b0;
	assign up_counter9_enable = (curr_state === get_data) ? 1'b1 : 1'b0;
	assign error_flag = (curr_state === error) ? 1'b1 : 1'b0;
	assign up_counter9_loud = (curr_state === get_first_data) ? 1'b1 : 1'b0;
	assign valid_output = (curr_state === get_data) | (curr_state === get_first_data) ? 1'b1 : 1'b0;
	assign shift_register_enable = (curr_state === get_info) ? 1'b1 : 1'b0;

	always @ (posedge clk, posedge rst)
	begin
		if (rst === 1'b1)
			curr_state <= 3'b000;
		else
			curr_state <= next_state;
	end
endmodule

module UpCounter3Bit_QC(input enable, clk, rst, output carry_out);
	logic [2 : 0] number;

	always @ (posedge clk, posedge rst)
	begin
		if (rst === 1'b1)
			number <= 0;
		else
			number <= number + enable;
	end

	assign carry_out = &{enable, number};
endmodule

module ShiftRegister_QC(input clk, SerIn, enable, output logic [7 : 0]out);

	always @ (posedge clk)
	begin
		if (enable === 1'b1)
			out <= {SerIn, out[7 : 1]};
	end
endmodule

module Fixer_QC(input [5 : 0]in, output [5 : 0]out, output carry_out);

	assign {carry_out, out} = {7'b1000000 - in};
endmodule

module UpCounter9Bit_QC(input enable, clk, loud, input [8 : 0]in, output carry_out);
	logic [8 : 0]number;

	always @ (posedge clk)
	begin
		if (loud === 1'b1)
			number <= in;
		else if (enable === 1'b1)
			number <= number + 1;
	end

	assign carry_out = &{number, enable};
endmodule

module Decoder_QC(input in, input [1 : 0]position, output logic [3 : 0]out);

	always @ (in, position)
	begin
		case(position)
			2'b11: out = {in, 1'b0, 1'b0, 1'b0};
			2'b10: out = {1'b0, in, 1'b0, 1'b0};
			2'b01: out = {1'b0, 1'b0, in, 1'b0};
			2'b00: out = {1'b0, 1'b0, 1'b0, in};
			default out = 2'b00;
		endcase
	end
endmodule