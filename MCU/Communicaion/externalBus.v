/////////////////////////////////////////////
// A simple bus design for interfacing :   //
//     a CPU -> AFTAB                      //
//     external chip components            //
// Writer: Amirmahdi Joudi                 //
// Date: 01/29/2023                        //
/////////////////////////////////////////////
`timescale 1ns/1ns
module externalBus (
    input clk,
    input rst,

    input CPU_MEM_READ,
    input CPU_MEM_WRITE,
    input [31:0] CPU_MEM_ADD,
    input [7:0] CPU_MEM_DATA_OUT,
    output [7:0] CPU_MEM_DATA_IN,

    output CPY_MEM_READY,

    output EXT_MEM_READ,
    output EXT_MEM_WRITE,
    output AE,
    inout [15:0] EXT_AD,
    input EXT_MEM_READY,

    output inDO,
    input inDI,
    input inSCK,
    input inCSbar,

    input exDO,
    output exDI,
    output exSCK,
    output exCSbar
);

    localparam [1:0] IDLE = 2'b00;
    localparam [1:0] ADD_LOW = 2'b01;
    localparam [1:0] ADD_HIGH = 2'b10;
    localparam [1:0] DT = 2'b11;

    reg [1:0] ps, ns;

    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= IDLE;
        else
            ps <= ns;
    end

    always @(ps, CPU_MEM_READ, CPU_MEM_WRITE, EXT_MEM_READY) begin
        ns <= IDLE;
        case (ps)
            IDLE: ns <= (CPU_MEM_READ || CPU_MEM_WRITE) ? ADD_LOW : IDLE;
            ADD_LOW: ns <= ADD_HIGH;
            ADD_HIGH: ns <= DT;
            DT: ns <= EXT_MEM_READY ? IDLE : DT;
        endcase
    end

    reg ADDtri;
    reg ADDsel;
    reg DTtri;
    reg AEreg;
    always @(ps, CPU_MEM_READ, CPU_MEM_WRITE, EXT_MEM_READY) begin
        {ADDtri, ADDsel, DTtri, AEreg} = 4'b0000;
        case (ps)
            IDLE: {ADDtri, ADDsel, DTtri} = 3'b000;
            ADD_LOW: {ADDtri, ADDsel, DTtri, AEreg} = 4'b1001;
            ADD_HIGH: {ADDtri, ADDsel, DTtri, AEreg} = 4'b1101;
            DT: {ADDtri, ADDsel, DTtri} = 3'b001;
        endcase
    end

    assign EXT_AD = (ADDtri) ? ((ADDsel == 1'b0) ? CPU_MEM_ADD[15:0] : CPU_MEM_ADD[31:16]) :
                    (DTtri && CPU_MEM_WRITE) ? {8'b0, CPU_MEM_DATA_OUT} : 16'bz;

    assign CPU_MEM_DATA_IN = (DTtri && CPU_MEM_READ && EXT_MEM_READY) ? EXT_AD[7:0] : 8'bz;//changed
    assign CPY_MEM_READY = EXT_MEM_READY;
    assign EXT_MEM_READ = CPU_MEM_READ;
    assign EXT_MEM_WRITE = CPU_MEM_WRITE;
    assign AE = AEreg;

    assign inDO = exDO;
    assign exDI = inDI;
    assign exSCK = inSCK;
    assign exCSbar = inCSbar;

endmodule