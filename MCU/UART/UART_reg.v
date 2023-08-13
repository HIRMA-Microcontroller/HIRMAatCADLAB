`timescale 1ns/1ns
module UART_reg (
    input clk,
    input rst,
    input load,
    input init,
    input [7:0] pload,
    output reg [7:0] pout
);


    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pout <= 8'b0;
        else if(init)
            pout <= 8'b0;
        else if (load == 1)
            pout <= pload;
    end


endmodule