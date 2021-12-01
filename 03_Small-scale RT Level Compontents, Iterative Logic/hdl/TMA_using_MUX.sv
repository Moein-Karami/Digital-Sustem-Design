`timescale 1ns/1ns

module TMA_using_MUX(input [1 : 0]a, [1: 0]b, input ci, output [1 : 0]s, output co);
    wire ci_bar;
    
    assign #(5, 7) ci_bar = ~ci;

    MUX_using_passtransistor_4 m1({ci, ci_bar, ci_bar, ci}, {a[0], b[0]}, s[0]);

    MUX_using_passtransistor_16 m2({1'b0, ci, 1'b1, ci_bar, ci, 1'b1, ci_bar, 1'b0, 1'b1, ci_bar, 1'b0, ci, ci_bar,
            1'b0, ci, 1'b1}, {a[1 : 0], b[1 : 0]}, s[1]);
    MUX_CMOS_16 m4({1'b0, 1'b0, 1'b0, ci, 1'b0, 1'b0, ci, 1'b1, 1'b0, ci, 1'b1, 1'b1, ci, 1'b1, 1'b1, 1'b1},
            {a[1 : 0], b[1 : 0]}, co);
endmodule