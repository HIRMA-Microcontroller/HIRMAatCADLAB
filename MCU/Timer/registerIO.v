`timescale 1ns/1ns
module CNFregister (
    input clk,
    input rst,
    input loadMem,
    input loadTmr,
    input init,
    input [7:0] pload,
    input co,
    output reg [7:0] pout
);


    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pout <= 8'b0;
        else if(init | pout[1])
            pout <= 8'b0;
        else if (loadMem == 1)
            pout[7:0] <= pload;
        else if (loadTmr == 1)
            pout[3] <= co;
    end


endmodule