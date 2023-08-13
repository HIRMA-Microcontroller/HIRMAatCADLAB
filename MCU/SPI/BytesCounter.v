`timescale 1ns/1ns
module BytesCounter (
    input clk,
    input rst,
    input initB,
    input incB,

    output align,
    output [3:0] cnt
);

    reg [3:0] cntOut;
    always @(posedge clk, posedge rst) begin
        if (rst)
            cntOut <= 4'b0;
        else if (initB)
            cntOut <= 4'b0;
        else if (incB)
            cntOut <= cntOut + 4'b1;
    end

    assign align = &cntOut ;
    assign cnt = cntOut;

endmodule