`timescale 1ns/1ns
module interleavedRegister (
    input clk,
    input rst,
    input load1,
    input load2,
    input load3,
    input load4,
    input init,
    input [7:0] pload,
    output reg [31:0] pout
);


    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pout <= 32'b0;
        else if(init)
            pout <= 32'b0;
        else if (load1 == 1)
            pout [7:0] <= pload;
        else if (load2 == 1)
            pout [15:8] <= pload;
        else if (load3 == 1)
            pout [23:16] <= pload;
        else if (load4 == 1)
            pout [31:24] <= pload;
        else
            pout <= pout;
    end


endmodule