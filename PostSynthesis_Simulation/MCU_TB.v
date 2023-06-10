`timescale 1ns/1ns
`define ARM_UD_MODEL
`define ARM_UD_DP
module MCU_TB();

    reg clk = 1'b0;
    reg rst = 1'b0;
    wire [7:0] DT;
    reg CORE_machineExternalInterrupt;
    wire EXT_READ;
    wire EXT_WRITE;
    wire AE;
    wire [15:0] EXT_AD;
    wire EXT_READY;
    wire DO;
    wire DI;
    wire SCK;
    wire CSbar;
    wire RX;
    wire TX;

    wire MEM_memRead;
    wire MEM_memWrite;
    wire [11:0] MEM_memAddr;
    wire [7:0] MEM_memDataIN;
    wire [7:0] MEM_memDataOut;

    assign EXT_AD[7:0] = EXT_READY ? DT : 8'bzzzzzzzz;
    assign RX = TX;
    MCU MICRO_CONTROLLER(
        .clk(clk),
        .rst(rst),
        .UART_RX(RX),
        .UART_TX(TX),

        .CORE_machineExternalInterrupt(CORE_machineExternalInterrupt),

        .EXT_READ(EXT_READ),
        .EXT_WRITE(EXT_WRITE),
        .EXT_AD(EXT_AD),
        .AE(AE),
        .EXT_READY(EXT_READY),

        .SRAM_address(MEM_memAddr),
        .SRAM_In(MEM_memDataIN),
        .SRAM_Read(MEM_memRead),
        .SRAM_Write(MEM_memWrite),
        .SRAM_Out(MEM_memDataOut),

        .SPI_DO(DO),
        .SPI_DI(DI),
        .SPI_SCK(SCK),
        .SPI_CSbar(CSbar)
    );

    aftab_memory_model #(
        .dataWidth(8),
        .addressWidth(32),
        .sector1Size(4096),
        .sector2Size(4096),
        .cycle(20),
        .timer(3500)
    ) MEMORY (
        .readmem(MEM_memRead),
        .writemem(MEM_memWrite),
        .addressBus({20'b00000000000000000000,MEM_memAddr}),
        .dataBusIn(MEM_memDataIN),
        .dataBusOut(MEM_memDataOut),
        .memDataReady()
    );

    reg status;
    reg [31:0] add;
    always @(posedge clk, posedge rst) begin
        if (rst)
            status <= 2'b00;
        else if (AE == 1'b0)
            status <= 1'b0;
        else if (AE == 1'b1 && status == 1'b0) begin
            add[15:0] <= EXT_AD;
            status <= 1'b1;
        end
        else if (AE == 1'b1 && status == 1'b1)begin
            add[31:16] <= EXT_AD;
            status <= 1'b0;
        end
    end

    reg [7:0] data;
    reg stat;
    always @(posedge clk, posedge rst) begin
        if (rst)
            data <= 8'b0;
        else if (stat)
            data <= EXT_AD[7:0];
    end
    always @(AE) begin
        if (AE == 1'b1)
            stat <= 1'b0;
        else
            stat <= 1'b1;
    end

    wire offEn;
    wire IOEn;
    assign IOEn = ((add[31:20] == 12'h1A1) & (add[19:17] == 3'b000));
    assign offEn = ({|{add[31:12]}}) & (IOEn == 1'b0);
    aftab_memory_model #(
        .dataWidth(8),
        .sector1Size(16384),
        .sector2Size(16384),
        .addressWidth(32),
        .cycle(50),
        .timer(36000)
    ) offChip (
        .readmem(EXT_READ & offEn),
        .writemem(EXT_WRITE & offEn),
        .addressBus(add),
        .dataBusIn(data),
        .dataBusOut(DT),
        .memDataReady(EXT_READY)
    );

    virtual_flash #(
        .SECTOR_DEPTH(4096)
    ) FLASH (
        .SCK(SCK),
        .CSbar(CSbar),
        .DI(DI),
        .DO(DO)
    );

    always #25 clk = ~clk;

    initial begin
        CORE_machineExternalInterrupt = 1'b0;
        #10000;
        rst = 1'b1;
        #1000;
        rst = 1'b0;
        #100000000;
        $stop;
    end

endmodule