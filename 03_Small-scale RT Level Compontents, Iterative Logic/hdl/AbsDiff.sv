`timescale 1ns/1ns

module AbsDiff(input [7 : 0]reff, input [7 : 0]data, output [7 : 0]ans);
    wire [7 : 0]rc;
    wire [7 : 0]dc;
    wire [7 : 0]a;
    wire [7 : 0]b;
    wire [7 : 0]I;
    wire [7 : 0]o;
    wire [7 : 0]tmp1;
    wire [7 : 0]tmp2;
    wire co0, co1, co, t1;
    wire carry0, carry1, carry, t2;
    
    genvar i;
    generate
        for (i = 0; i < 8; i++)
            assign #(5, 7) rc[i] = ~reff[i];
    endgenerate
    genvar j;
    generate
        for (j = 0; j < 8; j++)
            assign #(5, 7) dc[j] = ~data[j];
    endgenerate

    NMI_using_TMI #(8) nmi1(rc, a, carry0);
    NMI_using_TMI #(8) nmi2(dc, b, co0);

    NMA_using_TMA #(8) adder1(reff, b, I, co1);
    NMA_using_TMA #(8) adder2(a, data, o, carry1);

    assign #(10, 14) t1 = ~(co0 | co1);
    assign #(5, 7) co = ~ t1;

    assign #(10, 14) t2 = ~(carry0 | carry1);
    assign #(5, 7) carry = ~ t2; 

    genvar k;
    generate
        for (k = 0; k < 8; k++)
        begin
            assign #(10, 8) tmp1[k] = ~(co & I[k]);
            assign #(10, 8) tmp2[k] = ~(carry & o[k]);
            assign #(10, 8) ans[k] = ~(tmp1[k] & tmp2[k]);
        end
    endgenerate
endmodule
