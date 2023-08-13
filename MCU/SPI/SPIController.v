`timescale 1ns/1ns
module SPIController(
    input clk,
    input rst,
    input memReady,
    input Empty,
    input [7:0] FIFO_data,

    output reg ReadFIFO,
    output reg Flash_Read,
    output memRead,
    output reg memWrite,
    output reg done,
    output [7:0] memdataOut,
    output [31:0] memAddress,
    output [23:0] Flah_Start
);

    // SPI address register
    wire [23:0] SPI_address;
    reg initP;
    reg incP;
    SPI_address_Register SPI_REG (
        .clk(clk),
        .rst(rst),
        .initP(initP),
        .incP(incP),
        .address(SPI_address)
    );

    // SRAM address register
    wire [12:0] SRAM_address;
    reg initR;
    reg incR;
    SRAM_address_Register SRAM_REG (
        .clk(clk),
        .rst(rst),
        .initR(initR),
        .incR(incR),
        .address(SRAM_address)
    );

    // Number of bytes writen
    reg initB;
    reg incB;
    wire alignB;
    BytesCounter BYTES_HANDLER(
        .clk(clk),
        .rst(rst),
        .initB(initB),
        .incB(incB),

        .align(alignB),
        .cnt()
    );

    // Number of sectors read
    reg initS;
    reg ldS;
    reg decS;
    wire finished;
    SectorsController SEC_CU (
        .clk(clk),
        .rst(rst),
        .initS(initS),
        .ldS(ldS),
        .decS(decS),
        .cntIn(FIFO_data),

        .finished(finished),
        .cnt()
    );

    reg [3:0] ps;
    reg [3:0] ns;

    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= 4'b0;
        else
            ps <= ns;
    end

    always @(ps, Empty, finished, memReady, alignB) begin
        ns = 4'b0000;
        case (ps)
            4'b0000: ns = 4'b0001;
            4'b0001: ns = 4'b0010;
            4'b0010: ns = (Empty==1'b0) ? 4'b0011 : 4'b0010;
            4'b0011: ns = 4'b0100;
            4'b0100: ns = 4'b0101;
            4'b0101: ns = (Empty==1'b0) ? 4'b0110 : 4'b0101;
            4'b0110: ns = 4'b0111;
            4'b0111: ns = (memReady==1'b1) ? 4'b1000 : 4'b0111;
            4'b1000: ns = 4'b1001;
            4'b1001: ns = (alignB==1'b1) ? 4'b1010 : 4'b0101;
            4'b1010: ns = 4'b1011;
            4'b1011: ns = (finished==1'b1) ? 4'b1101 : 4'b1100;
            4'b1100: ns = 4'b0101;
            4'b1101: ns = 4'b1101;
            default: ns = 4'b0000;
        endcase
    end

    always @(ps, Empty, finished, memReady, alignB) begin
        initP = 1'b0;
        initR = 1'b0;
        initS = 1'b0;
        initB = 1'b0;
        Flash_Read = 1'b0;
        ldS = 1'b0;
        ReadFIFO = 1'b0;
        incB = 1'b0;
        incP = 1'b0;
        incR = 1'b0;
        decS = 1'b0;
        memWrite = 1'b0;
        done = 1'b0;
        case (ps)
            4'b0000: {initP, initR, initS, initB} = 4'b1111;
            4'b0001: Flash_Read = 1'b1;
            4'b0010: ;
            4'b0011: {ReadFIFO, incB} = 2'b11;
            4'b0100: ldS = 1'b1;
            4'b0101: ;
            4'b0110: ReadFIFO = 1'b1;
            4'b0111: memWrite = 1'b1;
            4'b1000: incR = 1'b1;
            4'b1001: incB = 1'b1;
            4'b1010: {decS, incP} = 2'b11;
            4'b1011: ;
            4'b1100: Flash_Read = 1'b1;
            4'b1101: done = 1'b1;
            default: ;
        endcase
    end

    assign memRead = 1'b0;
    assign memAddress = SRAM_address;
    assign Flah_Start = SPI_address;

endmodule