`timescale 1ns/1ns

module NMA_using_TMA #(parameter S = 8)(input [S - 1 : 0]a, input [S - 1 : 0]b, output [S - 1 : 0]s, output carry_out);
    parameter n = S / 2;
    wire c[n : 0];
    assign c[0] = 1'b0;
    assign carry_out = c[n];

    genvar i;
    generate
        for (i = 0; i < n; i++)
        begin : NMA
            TMA_using_MUX XX(a[2 * i + 1 : 2 * i], b[2 * i + 1 : 2 * i], c[i], s[2 * i + 1 : 2 * i], c[i + 1]);
        end
    endgenerate
endmodule