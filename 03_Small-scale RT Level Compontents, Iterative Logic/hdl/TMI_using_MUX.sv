`timescale 1ns/1ns

module TMI_using_MUX(input [1 : 0]a, input ci, output [1 : 0]s, output co);
    assign #(5, 7) a1_bar = ~a[1];
    assign #(5, 7) ci_bar = ~ci;
    MUX_using_passtransistor_2 m1({ci, ci_bar}, a[0], s[0]);
    MUX_using_passtransistor_4 m2({1'b0, ci ,1'b1, ci_bar}, a[1 : 0], s[1]);
    MUX_CMOS_4 m3({1'b0, 1'b0, 1'b0, ci}, a[1 : 0], co);
endmodule