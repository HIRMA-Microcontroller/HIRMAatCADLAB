`timescale 1ns/1ns
module SRAM_address_Register (
    input clk,
    input rst,
    input initR,
    input incR,

    output [12:0] address
);

    reg [12:0] SRAM_address;
    always @(posedge clk, posedge rst) begin
        if (rst)
            SRAM_address <= 13'b0;
        else if (initR)
            SRAM_address <= 13'b0;
        else if (incR)
            SRAM_address <= SRAM_address + 13'b1;
    end

    assign address = SRAM_address;

endmodule