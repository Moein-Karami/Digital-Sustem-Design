`timescale 1ns/1ns

module LessDistance (input [7 : 0]reff, input [7 : 0]dataA, input [7 : 0]dataB, output [7 : 0]ans);
    wire [7 : 0]diff1;
    wire [7 : 0]diff2;
    wire EQ, GT;

    AbsDiff Diff1(reff, dataA, diff1);
    AbsDiff Diff2(reff, dataB, diff2);

    NCS_using_generate_TCS compare(diff1, diff2, EQ, GT);

    genvar i;
    generate
        for (i = 0; i < 8; i++)
            MUX_CMOS_2 MM({dataB[i], dataA[i]}, GT, ans[i]);
    endgenerate
endmodule
