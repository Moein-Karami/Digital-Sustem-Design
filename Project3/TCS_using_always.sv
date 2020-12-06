`timescale 1ns/1ns

module TCS_using_always(input [1 : 0]a, [1 : 0]b, input eq, gt, output logic EQ, GT);
    
    always @(a, b, eq, gt)
    begin
        // if (gt === 1'b1)
        //     #19 assign {GT, EQ} = {1'b1, 1'b0};
        // else if (eq === 1'b1)
        // begin
        //     if (b > a)
        //         #59 assign {EQ, GT} = {1'b0, 1'b1};
        //     else if (b === a)
        //         #57 assign {EQ, GT} = {1'b1, 1'b0};
        //     else if (b < a)
        //         #57 assign {EQ, GT} = {1'b0, 1'b0};
        // end
        // else if (eq === 1'b0 && gt === 1'b0)
        //     #29 assign {EQ, GT} = {1'b0, 1'b0};

    // always @(a, b, eq, gt)
    // begin
    //     if (gt === 1'b1)
    //     begin
    //         GT <= #17 1'b1;
    //         EQ <= #2 1'b0;
    //     end
    //     else if (eq === 1'b1)
    //     begin
    //         if (b > a)
    //         begin
    //             EQ <= #36 1'b0;
    //             GT <= #23 1'b1;
    //         end
    //         else if (b === a)
    //         begin
    //             EQ <= #31 1'b1;
    //             GT <= #26 1'b0;
    //         end
    //         else if (b < a)
    //         begin
    //             EQ <= #36 1'b0;
    //             GT <= #57 1'b0;
    //         end
    //     end
    //     else if (eq === 1'b0 && gt === 1'b0)
    //     begin
    //         GT <= #18 1'b0;
    //         EQ <= #11 1'b0;
    //     end
        //assign {EQ, GT} = {1'bx, 1'bx};
        // #59 assign {EQ, GT} = gt ? {0, 1}:
        //                         eq ? {a === b, b > a}:
        //                         {0, 0};

        #59;
        if (gt === 1'b1)
            assign {EQ, GT} = {1'b0, 1'b1};
        else if (eq === 1'b1)
        begin
            if (b > a)
                assign {EQ, GT} = {1'b0, 1'b1};
            else if (a === b)
                assign {EQ, GT} = {1'b1, 1'b0};
            else if (a > b)
                assign {EQ, GT} = {1'b0, 1'b0};
        end
        else if (eq === 1'b0 && gt === 1'b0)
            assign {EQ, GT} = {1'b0, 1'b0};


        // if (gt === 1'b1)
        // begin 
        //     #19 assign EQ = 1'b0;
        // end
        // else if (eq === 1'b1)
        // begin
        //     if (b === a)
        //         #31 assign EQ = 1'b1;
        //     else
        //         #36 assign EQ = 1'b0;
        // end
        // else if (eq === 1'b0 && gt === 1'b0)
        // begin
        //     #29 assign EQ = 1'b0;
        // end
    end

    // always @(a, b, eq, gt)
    // begin
    //     if (gt === 1'b1)
    //     begin 
    //         #17 assign GT = 1'b1;
    //     end
    //     else if (eq === 1'b1)
    //     begin
    //         if (b > a)
    //            #59 assign GT = 1'b1;
    //         else 
    //             #57 assign GT = 1'b0;
    //     end
    //     else if (eq === 1'b0 && gt === 1'b0)
    //     begin
    //         #18 assign GT = 1'b0;
    //     end
    // end
endmodule