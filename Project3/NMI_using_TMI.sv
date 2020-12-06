`timescale 1ns/1ns

module NMI_using_TMI #(parameter S = 8)(input [S - 1 : 0] a, output [S - 1 : 0]s, output co);
    parameter n = S / 2;
    wire c[n : 0];
    assign co = c[n];
    assign c[0] = 1'b1;
    genvar i;
    generate
        for (i = 0; i < n; i++)
        begin : NMI
            TMI_using_MUX XX(a[2 * i + 1 : 2 * i], c[i], s[2 * i + 1 : 2 * i], c[i + 1]);
        end
    endgenerate
endmodule