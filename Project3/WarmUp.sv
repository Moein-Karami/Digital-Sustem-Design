`timescale 1ns/1ns

module tb();
    logic l1, l2, l3;
    
    initial
    begin 
        l1 = 0;
        l2 = 0;
        l3 = 0;
        #1000 $stop;
    end
    always #100 l1 = ~l1;
endmodule