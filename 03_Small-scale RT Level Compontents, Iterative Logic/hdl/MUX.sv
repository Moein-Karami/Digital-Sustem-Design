`timescale 1ns/1ns

module MUX_using_passtransistor_2(input [0 : 1]I, input S, output w);
    assign #7 w = I[S];
endmodule

module MUX_using_passtransistor_4(input [0 : 3]I, input [1 : 0]S, output w);
    assign #14 w = I[S];
endmodule

module MUX_using_passtransistor_16(input [0 : 15]I, input [3 : 0]S, output w);
    assign #28 w = I[S];
endmodule

module MUX_CMOS_2(input [0 : 1]I, input S, output w);
    assign #(23, 25) w = I[S];
endmodule

module MUX_CMOS_16(input [0 : 15]I, input [3 : 0]S, output w);
    assign #(96, 105) w = I[S];
endmodule

module MUX_CMOS_4(input [0 : 3]I, input [1 : 0]S, output w);
    assign #(37, 38) w = I[S];
endmodule