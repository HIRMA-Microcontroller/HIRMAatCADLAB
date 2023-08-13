`timescale 1ns/1ns
module counterIO (
    input clk,
    input rst,

    input [31:0] initialLoad,
    input [31:0] coValLoad,

    input init,
    input cntEn,

    output co
);

    reg [31:0] cntVal;
    always @(posedge clk, posedge rst) begin
        if (rst)
            cntVal <= 32'b0;
        else if (init | co)
            cntVal <= initialLoad;
        else if (cntEn)
            cntVal <= cntVal + 1;
    end

    assign co = (cntVal == coValLoad);


endmodule