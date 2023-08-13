`timescale 1ns/1ns
module UART_interface (
    input clk,
    input rst,

    input RX_bits,

    input BRl1,
    input BRl2,
    input BRl3,
    input BRl4,
    input BRInit,

    input ldTx,

    input [7:0] pload,

    input loadMem,
    input initCnf,
    input [7:0] CnfIn,

    output TX_bits,

    output [7:0] CnfOut,
    output [7:0] RXdata,
    output InterruptTX,
    output InterruptRX
);

    wire initCNF;
    wire TX_INT_EN;
    wire RX_INT_EN;
    wire LD_BR;
    wire TX_start;
    wire TX_active;
    wire TX_Done;
    wire RX_Done;

    wire [31:0] BRout;
    wire [7:0] TX_Byte;
    wire [7:0] RX_Byte;
    interleavedRegister BRreg (
        .clk(clk),
        .rst(rst),
        .load1(BRl1),
        .load2(BRl2),
        .load3(BRl3),
        .load4(BRl4),
        .init(BRInit),
        .pload(pload),
        .pout(BRout)
    );

    UART_reg TXreg(
        .clk(clk),
        .rst(rst),
        .load(ldTx),
        .init(1'b0),
        .pload(pload),
        .pout(TX_Byte)
    );

    UART_reg RXreg(
        .clk(clk),
        .rst(rst),
        .load(RX_Done),
        .init(1'b0),
        .pload(RX_Byte),
        .pout(RXdata)
    );

    uart UART(
        .CLKS_PER_BIT(BRout),
        .ld_CLKS_PER_BIT(LD_BR),
        .i_Clock(clk),
        .rst(rst),
        .i_Tx_DV(TX_start),
        .i_Tx_Byte(TX_Byte),
        .o_Tx_Active(TX_active),
        .o_Tx_Serial(TX_bits),
        .o_Tx_Done(TX_Done),
        .i_Rx_Serial(RX_bits),
        .o_Rx_DV(RX_Done),
        .o_Rx_Byte(RX_Byte)
    );

    UART_Conf CNFreg (
        .clk(clk),
        .rst(rst),
        .loadMem(loadMem),
        .loadTXactive(TX_active),
        .loadTXdone(TX_Done),
        .loadRXdone(RX_Done),
        .init(initCNF),
        .pload(CnfIn),
        .TXactive(TX_active),
        .TXdone(TX_Done),
        .RXdone(RX_Done),
        .pout(CnfOut)
    );
    assign initCNF = CnfOut[0];
    assign TX_INT_EN = CnfOut[1];
    assign RX_INT_EN = CnfOut[2];
    assign LD_BR = CnfOut[3];
    assign TX_start = CnfOut[4];

    assign InterruptTX = TX_INT_EN ? CnfOut[6] : 1'b0;
    assign InterruptRX = RX_INT_EN ? CnfOut[7] : 1'b0;

endmodule