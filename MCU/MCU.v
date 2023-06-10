`timescale 1ns/1ns
module MCU (
    input clk,
    input rst,

    input UART_RX,
    output UART_TX,
    input CORE_machineExternalInterrupt,

    output EXT_READ,
    output EXT_WRITE,
    output AE,
    inout [15:0] EXT_AD,
    input EXT_READY,

    output [11:0] SRAM_address,
    output [7:0] SRAM_In,
    output SRAM_Read,
    output SRAM_Write,
    input [7:0] SRAM_Out,

    input SPI_DO,
    output SPI_DI,
    output SPI_SCK,
    output SPI_CSbar
);


    wire CORE_memReady;
    wire [7:0] CORE_memData_IN;
    wire [7:0] CORE_memData_OUT;
    wire [7:0] CORE_memData1;
    wire [7:0] CORE_memData2;
    wire CORE_memRead;
    wire CORE_memWrite;
    wire [31:0] CORE_memAddr;
    wire CORE_machineTimerInterrupt;
    wire CORE_machineSoftwareInterrupt;
    wire CORE_userExternalInterrupt;
    wire CORE_userTimerInterrupt;
    wire CORE_userSoftwareInterrupt;
    wire [15:0] CORE_platformInterruptSignals;
    wire CORE_interruptProcessing;

    assign CORE_userTimerInterrupt = 1'b0;
    assign CORE_userExternalInterrupt = 1'b0;
    assign CORE_userSoftwareInterrupt = 1'b0;
    assign CORE_platformInterruptSignals = 16'b0;

    wire MEM_memReady;
    wire externalReady;
    wire internalReady;
    wire [7:0] MEM_memDataIN;
    wire [7:0] MEM_memDataOUT;
    wire MEM_memRead;
    wire MEM_memWrite;
    wire [31:0] MEM_memAddr;

    wire [31:0] SPI_Add;
    wire [7:0] SPI_Data;
    wire SPI_Read;
    wire SPI_Write;
    wire SPI_Ready;

    wire offChipEn;
    wire IOEn;
    wire InternalIO;

    wire [7:0] TMR2CORE;
    // -------------------------------------------------------------------------------------- MASTER 1
    wire Empty;
    wire [7:0] FIFO_Data;
    wire ReadFIFO;
    wire Flash_Read;
    wire done;
    wire [23:0] Flash_address;
    SPIController SPI_CU(
        .clk(clk),
        .rst(rst),
        .memReady(SPI_Ready),
        .Empty(Empty),
        .FIFO_data(FIFO_Data),

        .ReadFIFO(ReadFIFO),
        .Flash_Read(Flash_Read),
        .memRead(SPI_Read),
        .memWrite(SPI_Write),
        .done(done),
        .memdataOut(SPI_Data),
        .memAddress(SPI_Add),
        .Flah_Start(Flash_address)
    );

    wire DO;
    wire DI;
    wire SCK;
    wire CSbar;
    FLASH_Controller FLASH (
        .clk(clk),
        .rst(rst),

        .read(1'b0),
        .read_chunk(Flash_Read),
        .write(1'b0),
        .numByte_read_wp(8'd16),
        .address_wp(Flash_address),

        .buf_out(FIFO_Data),
        .rden(ReadFIFO),
        .buf_empty(Empty),
        .buf_full(),

        .DO(DO),
        .DI(DI),
        .SCK(SCK),
        .CSbar(CSbar)
    );

    // -------------------------------------------------------------------------------------- MASTER 2
    aftab_core #(
        .size(32)
    ) CORE (
        .clk(clk),
        .rst(rst),
        .memReady(CORE_memReady),
        .memDataIn(CORE_memData_IN),
        .memDataOut(CORE_memData_OUT),
        .memRead(CORE_memRead),
        .memWrite(CORE_memWrite),
        .memAddr(CORE_memAddr),
        .machineExternalInterrupt(CORE_machineExternalInterrupt),
        .machineTimerInterrupt(CORE_machineTimerInterrupt),
        .machineSoftwareInterrupt(CORE_machineSoftwareInterrupt),
        .userExternalInterrupt(CORE_userExternalInterrupt),
        .userTimerInterrupt(CORE_userTimerInterrupt),
        .userSoftwareInterrupt(CORE_userSoftwareInterrupt),
        .platformInterruptSignals(CORE_platformInterruptSignals),
        .interruptProcessing(CORE_interruptProcessing)
    );

    // -------------------------------------------------------------------------------------- UART
    // assign CORE_machineTimerInterrupt = 1'b0;
    // wire timer_int;

    wire chooseURT_CNF2CORE;
    wire chooseURT_RX2CORE;
    wire chooseURT_BR1;
    wire chooseURT_BR2;
    wire chooseURT_BR3;
    wire chooseURT_BR4;
    wire chooseURT_TX;
    wire chooseURT_CNF;
    assign chooseURT_CNF2CORE = (MEM_memRead == 1'b1 && (MEM_memAddr == 32'h1A10FFE4)) ? 1'b1 : 1'b0;
    assign chooseURT_RX2CORE = (MEM_memRead == 1'b1 && (MEM_memAddr == 32'h1A10FFDC)) ? 1'b1 : 1'b0;
    assign chooseURT_BR1 = ((MEM_memAddr == 32'h1A10FFD8) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseURT_BR2 = ((MEM_memAddr == 32'h1A10FFD9) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseURT_BR3 = ((MEM_memAddr == 32'h1A10FFDA) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseURT_BR4 = ((MEM_memAddr == 32'h1A10FFDB) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseURT_TX = ((MEM_memAddr == 32'h1A10FFE0) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseURT_CNF = ((MEM_memAddr == 32'h1A10FFE4) & MEM_memWrite) ? 1'b1 : 1'b0;

    assign InternalIO = ((MEM_memAddr[31:8] == 24'h1A10FF) && (MEM_memAddr[7:6] == 2'b11)) ? 1'b1 : 1'b0;
    wire URT_RINT;
    wire URT_TINT;
    assign CORE_machineSoftwareInterrupt = URT_TINT | URT_RINT;
    // assign CORE_machineSoftwareInterrupt = URT_TINT | URT_RINT | timer_int;
    wire [7:0] URT_CNT2CORE;
    wire [7:0] URT_RX2CORE;
    assign MEM_memDataOUT = (chooseURT_CNF2CORE == 1'b1) ? URT_CNT2CORE : 8'bzzzzzzzz;
    assign MEM_memDataOUT = (chooseURT_RX2CORE == 1'b1) ? URT_RX2CORE : 8'bzzzzzzzz;
    UART_interface URT(
        .clk(clk),
        .rst(rst),

        .RX_bits(UART_RX),

        .BRl1(chooseURT_BR1),
        .BRl2(chooseURT_BR2),
        .BRl3(chooseURT_BR3),
        .BRl4(chooseURT_BR4),
        .BRInit(1'b0),

        .ldTx(chooseURT_TX),

        .pload(MEM_memDataIN),

        .loadMem(chooseURT_CNF),
        .initCnf(1'b0),
        .CnfIn(MEM_memDataIN),

        .TX_bits(UART_TX),

        .CnfOut(URT_CNT2CORE),
        .RXdata(URT_RX2CORE),
        .InterruptTX(URT_TINT),
        .InterruptRX(URT_RINT)
    );

    // -------------------------------------------------------------------------------------- Timer
    wire chooseTMR_TMR2CORE;
    wire chooseTMR_iload1;
    wire chooseTMR_iload2;
    wire chooseTMR_iload3;
    wire chooseTMR_iload4;
    wire chooseTMR_cload1;
    wire chooseTMR_cload2;
    wire chooseTMR_cload3;
    wire chooseTMR_cload4;
    wire chooseTMR_CNF;
    assign chooseTMR_TMR2CORE = (MEM_memRead == 1'b1 && (MEM_memAddr == 32'h1A10FFF0)) ? 1'b1 : 1'b0;
    assign chooseTMR_iload1 = ((MEM_memAddr == 32'h1A10FFE8) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_iload2 = ((MEM_memAddr == 32'h1A10FFE9) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_iload3 = ((MEM_memAddr == 32'h1A10FFEA) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_iload4 = ((MEM_memAddr == 32'h1A10FFEB) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_cload1 = ((MEM_memAddr == 32'h1A10FFEC) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_cload2 = ((MEM_memAddr == 32'h1A10FFED) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_cload3 = ((MEM_memAddr == 32'h1A10FFEE) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_cload4 = ((MEM_memAddr == 32'h1A10FFEF) & MEM_memWrite) ? 1'b1 : 1'b0;
    assign chooseTMR_CNF = ((MEM_memAddr == 32'h1A10FFF0) & MEM_memWrite) ? 1'b1 : 1'b0;

    assign MEM_memDataOUT = (chooseTMR_TMR2CORE == 1'b1) ? TMR2CORE : 8'bzzzzzzzz;
    timerIO TMR (
        .clk(clk),
        .rst(rst),

        .ilLoad1(chooseTMR_iload1),
        .ilLoad2(chooseTMR_iload2),
        .ilLoad3(chooseTMR_iload3),
        .ilLoad4(chooseTMR_iload4),
        .ilInit(1'b0),

        .cvLoad1(chooseTMR_cload1),
        .cvLoad2(chooseTMR_cload2),
        .cvLoad3(chooseTMR_cload3),
        .cvLoad4(chooseTMR_cload4),
        .cvInit(1'b0),

        .pload(MEM_memDataIN),

        .loadMem(chooseTMR_CNF),
        .initCnf(1'b0),
        .CnfIn(MEM_memDataIN),

        .CnfOut(TMR2CORE),
        .Interrupt(CORE_machineTimerInterrupt)
        // .Interrupt(timer_int)
    );

    // -------------------------------------------------------------------------------------- SLAVE (Memory Ready Generator)
    assign IOEn = (MEM_memRead||MEM_memWrite) ? ((MEM_memAddr[31:20] == 12'h1A1) & (MEM_memAddr[19:17] == 3'b000)) : 1'b0;
    assign offChipEn = (MEM_memRead||MEM_memWrite) ? ((~(MEM_memAddr[31:12] == 20'b0)) & (IOEn == 1'b0)) : 1'b0;
    assign SRAM_address = (~offChipEn) ? MEM_memAddr[11:0] : 12'bz;
    assign SRAM_In = (~offChipEn) ? MEM_memDataIN : 8'bz;
    assign SRAM_Read = MEM_memRead & (~offChipEn) & (~IOEn);
    assign SRAM_Write = MEM_memWrite & (~offChipEn) & (~IOEn);
    assign MEM_memDataOUT = (MEM_memRead == 1'b1 && (IOEn || offChipEn)) ? 8'bzzzzzzzz : SRAM_Out;

    wire IOVALld;
    assign IOVALld = ((MEM_memAddr == 32'h1A10FFF4) && MEM_memWrite) ? 1'b1 : 1'b0;
	reg [7:0] IOVal;
    always @(posedge clk, posedge rst) begin
        if (rst)
            IOVal <= 8'h05;
        else if (IOVALld)
            IOVal <= MEM_memDataIN;
    end

    wire onChipLd1;
    wire onChipLd2;
    wire onChipLd3;
    wire onChipLd4;
    assign onChipLd1 = ((MEM_memAddr == 32'h1A10FFF8) && MEM_memWrite) ? 1'b1 : 1'b0;
    assign onChipLd2 = ((MEM_memAddr == 32'h1A10FFF9) && MEM_memWrite) ? 1'b1 : 1'b0;
    assign onChipLd3 = ((MEM_memAddr == 32'h1A10FFFA) && MEM_memWrite) ? 1'b1 : 1'b0;
    assign onChipLd4 = ((MEM_memAddr == 32'h1A10FFFB) && MEM_memWrite) ? 1'b1 : 1'b0;

    reg [31:0] onChipVal;
    always @(posedge clk, posedge rst) begin
        if (rst)
            onChipVal <= 32'h00000200;
        else if (onChipLd1)
            onChipVal[7:0] <= MEM_memDataIN;
        else if (onChipLd2)
            onChipVal[15:8] <= MEM_memDataIN;
        else if (onChipLd3)
            onChipVal[23:16] <= MEM_memDataIN;
        else if (onChipLd4)
            onChipVal[31:24] <= MEM_memDataIN;
    end

    wire offChipLd1;
    wire offChipLd2;
    wire offChipLd3;
    wire offChipLd4;
    assign offChipLd1 = ((MEM_memAddr == 32'h1A10FFFC) && MEM_memWrite) ? 1'b1 : 1'b0;
    assign offChipLd2 = ((MEM_memAddr == 32'h1A10FFFD) && MEM_memWrite) ? 1'b1 : 1'b0;
    assign offChipLd3 = ((MEM_memAddr == 32'h1A10FFFE) && MEM_memWrite) ? 1'b1 : 1'b0;
    assign offChipLd4 = ((MEM_memAddr == 32'h1A10FFFF) && MEM_memWrite) ? 1'b1 : 1'b0;

    reg [31:0] offChipVal;
    always @(posedge clk, posedge rst) begin
        if (rst)
            offChipVal <= 32'h00003FFF;
        else if (offChipLd1)
            offChipVal[7:0] <= MEM_memDataIN;
        else if (offChipLd2)
            offChipVal[15:8] <= MEM_memDataIN;
        else if (offChipLd3)
            offChipVal[23:16] <= MEM_memDataIN;
        else if (offChipLd4)
            offChipVal[31:24] <= MEM_memDataIN;
    end

    reg [31:0] readyReg;
    always @(posedge clk, posedge rst) begin
        if (rst)
            readyReg <= 32'd0;
        else if (IOEn)
            readyReg <= IOVal;
        else if (offChipEn)
            readyReg <= offChipVal;
        else
            readyReg <= onChipVal;
    end

    reg [31:0] cnt;
    always @(posedge clk, posedge rst) begin
        if (rst)
            cnt <= 32'd0;
        else if (internalReady|EXT_READY)
            cnt <= 32'd0;
        else if (MEM_memRead|MEM_memWrite)
            cnt <= cnt + 32'd1;
    end
    assign internalReady = (cnt == readyReg) ? 1'b1 : 1'b0;
    assign MEM_memReady = ((CORE_memRead||CORE_memWrite)&&offChipEn) ? externalReady : internalReady;

    // -------------------------------------------------------------------------------------- BUSING (Internal Bus)
    internalBus INTERNAL_BUS (
        .clk(clk),
        .rst(rst),

        .MASTER1_ADD(SPI_Add),
        .MASTER2_ADD(CORE_memAddr),
        .SLAVE_ADD(MEM_memAddr),

        .MASTER1_DATA_IN(),
        .MASTER2_DATA_IN(CORE_memData_IN),
        .SLAVE_DATA_IN(MEM_memDataIN),

        .MASTER1_DATA_OUT(FIFO_Data),
        .MASTER2_DATA_OUT(CORE_memData_OUT),
        .SLAVE_DATA_OUT(MEM_memDataOUT),

        .MASTER1_READ(SPI_Read),
        .MASTER2_READ(CORE_memRead),
        .SLAVE_READ(MEM_memRead),

        .MASTER1_WRITE(SPI_Write),
        .MASTER2_WRITE(CORE_memWrite),
        .SPI_request(~done),
        .SLAVE_WRITE(MEM_memWrite),

        .MASTER1_READY(SPI_Ready),
        .MASTER2_READY(CORE_memReady),
        .SLAVE_READY(MEM_memReady)
    );

    // -------------------------------------------------------------------------------------- BUSING (External Bus)
    assign MEM_memDataOUT  = (CORE_memRead == 1'b1 && (~(MEM_memAddr[31:12] == 20'b0)) && ~InternalIO) ? CORE_memData2 : 8'bzzzzzzzz;
    assign CORE_memData1 = (CORE_memWrite == 1'b1) ? CORE_memData_OUT : 8'bzzzzzzzz;
    externalBus EXTERNAL_BUS (
        .clk(clk),
        .rst(rst),

        .CPU_MEM_READ(CORE_memRead),
        .CPU_MEM_WRITE(CORE_memWrite),
        .CPU_MEM_ADD(CORE_memAddr),
        .CPU_MEM_DATA_OUT(CORE_memData1),
        .CPU_MEM_DATA_IN(CORE_memData2),
        .CPY_MEM_READY(externalReady),

        .EXT_MEM_READ(EXT_READ),
        .EXT_MEM_WRITE(EXT_WRITE),
        .AE(AE),
        .EXT_AD(EXT_AD),
        .EXT_MEM_READY(internalReady|EXT_READY),

        .inDO(DO),
        .inDI(DI),
        .inSCK(SCK),
        .inCSbar(CSbar),

        .exDO(SPI_DO),
        .exDI(SPI_DI),
        .exSCK(SPI_SCK),
        .exCSbar(SPI_CSbar)
    );

endmodule