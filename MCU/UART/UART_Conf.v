`timescale 1ns/1ns
module UART_Conf (
    input clk,
    input rst,
    input loadMem,
    input loadTXactive,
    input loadTXdone,
    input loadRXdone,
    input init,
    input [7:0] pload,
    input TXactive,
    input TXdone,
    input RXdone,
    output reg [7:0] pout
);


    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pout[4:0] <= 5'b0;
        else if(init)
            pout[4:0] <= 5'b0;
        else if (loadMem == 1)
            pout[4:0] <= pload[4:0];
        else if (loadTXdone == 1)
            pout[4] <= 1'b0;
    end

    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pout[5] <= 1'b0;
        else if(init)
            pout[5] <= 1'b0;
        else if (loadMem == 1)
            pout[5] <= pload[5];
        else if (loadTXactive == 1 || loadTXdone == 1'b1)
            pout[5] <= TXactive;
    end

    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pout[6] <= 1'b0;
        else if(init)
            pout[6] <= 1'b0;
        else if (loadMem == 1)
            pout[6] <= pload[6];
        else if (loadTXdone == 1)
            pout[6] <= TXdone;
    end

    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pout[7] <= 1'b0;
        else if(init)
            pout[7] <= 1'b0;
        else if (loadMem == 1)
            pout[7] <= pload[7];
        else if (loadRXdone == 1)
            pout[7] <= RXdone;
    end


endmodule