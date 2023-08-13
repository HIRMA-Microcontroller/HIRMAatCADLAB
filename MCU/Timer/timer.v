`timescale 1ns/1ns
module timerIO (
    input clk,
    input rst,

    input ilLoad1,
    input ilLoad2,
    input ilLoad3,
    input ilLoad4,
    input ilInit,

    input cvLoad1,
    input cvLoad2,
    input cvLoad3,
    input cvLoad4,
    input cvInit,

    input [7:0] pload,

    input loadMem,
    input initCnf,
    input [7:0] CnfIn,

    output [7:0] CnfOut,
    output Interrupt
);

    wire startTimer;
    wire initTimer;
    wire enableInterrupt;
    wire [31:0] ilOut;
    interleavedRegister initialLoad (
        .clk(clk),
        .rst(rst),
        .load1(ilLoad1),
        .load2(ilLoad2),
        .load3(ilLoad3),
        .load4(ilLoad4),
        .init(ilInit),
        .pload(pload),
        .pout(ilOut)
    );

    wire [31:0] cvOut;
    interleavedRegister coValueLoad (
        .clk(clk),
        .rst(rst),
        .load1(cvLoad1),
        .load2(cvLoad2),
        .load3(cvLoad3),
        .load4(cvLoad4),
        .init(cvInit),
        .pload(pload),
        .pout(cvOut)
    );

    wire co;
    counterIO countr (
        .clk(clk),
        .rst(rst),
        .initialLoad(ilOut),
        .coValLoad(cvOut),
        .init(initTimer),
        .cntEn(startTimer),
        .co(co)
    );

    CNFregister ConfReg (
        .clk(clk),
        .rst(rst),
        .loadMem(loadMem),
        .loadTmr(co),
        .init(initCnf),
        .pload(CnfIn),
        .co(co),
        .pout(CnfOut)
    );
    assign enableInterrupt = CnfOut[2];
    assign initTimer = CnfOut[1];
    assign startTimer = CnfOut[0];

    assign Interrupt = enableInterrupt ? CnfOut[3] : 1'b0;

endmodule