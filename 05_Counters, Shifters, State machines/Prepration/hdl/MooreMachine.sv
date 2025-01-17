`timescale 1ns/1ns

module MooreMachine1011(input clk, rst, in, output out);
	logic [2 : 0]curr_state;
	logic [2 : 0]next_state;

	always @(in, curr_state)
	begin
		case(curr_state)
			3'b000: next_state = in ? 3'b001 : 3'b000;
			3'b001: next_state = in ? 3'b001 : 3'b010;
			3'b010: next_state = in ? 3'b011 : 3'b000;
			3'b011: next_state = in ? 3'b100 : 3'b010;
			3'b100: next_state = in ? 3'b001 : 3'b010;
			default: next_state = 3'b000;
		endcase
	end

	assign out = (curr_state == 3'b100) ? 1 : 0;

	always @(posedge clk, posedge rst)
	begin
		if (rst)
			curr_state <= 3'b000;
		else
			curr_state <= next_state;
	end
endmodule