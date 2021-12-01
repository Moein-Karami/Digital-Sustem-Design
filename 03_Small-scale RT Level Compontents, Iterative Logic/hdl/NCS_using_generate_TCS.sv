`timescale 1ns/1ns

module NCS_using_generate_TCS #(parameter S = 8) (input [S - 1 : 0]a, [S - 1 : 0]b, output EQ, GT);
    parameter n = S / 2;
    wire [n : 0]eq;
    wire [n : 0]gt;
    assign eq[n] = 1;
    assign gt[n] = 0;
    genvar i;
    generate
        for (i = n; i > 0; i--) 
        begin : Comparator
            TCS_using_always XX(a[2 * i - 1 : 2 * i - 2], b[2 * i - 1 : 2 * i - 2], eq[i], gt[i], eq[i - 1], gt[i - 1]);
        end
    endgenerate

    assign EQ = eq[0];
    assign GT = gt[0];

endmodule