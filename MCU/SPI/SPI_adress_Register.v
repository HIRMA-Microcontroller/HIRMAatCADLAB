`timescale 1ns/1ns
module SPI_address_Register (
    input clk,
    input rst,
    input initP,
    input incP,
    output [23:0] address
);

    reg [23:0] SPI_address;
    always @(posedge clk, posedge rst) begin
        if (rst)
            SPI_address <= 24'b0;
        else if (initP)
            SPI_address <= 24'b0;
        else if (incP)
            SPI_address <= SPI_address + 24'd16;
    end

    assign address = SPI_address;

endmodule