`timescale 1ns/1ns
module SectorsController (
    input clk,
    input rst,
    input initS,
    input ldS,
    input decS,
    input [7:0] cntIn,

    output finished,
    output [7:0] cnt
);

    reg [7:0] cntOut;
    always @(posedge clk, posedge rst) begin
        if (rst)
            cntOut <= 8'b0;
        else if (initS)
            cntOut <= 8'b0;
        else if (ldS)
            cntOut <= cntIn;
        else if (decS)
            cntOut <= cntOut - 8'b0000001;
    end

    assign finished = ~(|cntOut);
    assign cnt = cntOut;

endmodule