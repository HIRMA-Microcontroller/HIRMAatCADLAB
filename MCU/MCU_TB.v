`timescale 1ns/1ns
module MCU_TB();

    reg clk = 1'b0;
    reg rst = 1'b0;
    wire [7:0] DT;
    reg CORE_machineExternalInterrupt;
    wire EXT_READ;
    wire EXT_WRITE;
    wire AE;
    wire OE;
    wire IE;
    wire [15:0] EXT_AD_OUT;
    wire [7:0] EXT_AD_IN;
    wire EXT_READY;
    wire DO;
    wire DI;
    wire SCK;
    wire CSbar;
    wire RX;
    wire TX;
    wire EN;

    wire MEM_memRead;
    wire MEM_memWrite;
    wire [11:0] MEM_memAddr;
    wire [7:0] MEM_memDataIN;
    wire [7:0] MEM_memDataOut;

    assign EXT_AD_IN = EXT_READY ? DT : 8'b0;
    assign RX = TX;
    MCU MICRO_CONTROLLER(
        .clk(clk),
        .rst(rst),
        .UART_RX(RX),
        .UART_TX(TX),

        .CORE_machineExternalInterrupt(CORE_machineExternalInterrupt),

        .EXT_READ(EXT_READ),
        .EXT_WRITE(EXT_WRITE),
        .EXT_AD_IN(EXT_AD_IN),
        .EXT_AD_OUT(EXT_AD_OUT),
        .AE(AE),
        .OE(OE),
        .IE(IE),
        .EXT_READY(EXT_READY),

        .SPI_DO(DO),
        .SPI_DI(DI),
        .SPI_SCK(SCK),
        .SPI_CSbar(CSbar),
        .EN(EN)
    );

    reg status;
    reg [31:0] add;
    always @(posedge clk, posedge rst) begin
        if (rst)
            status <= 2'b00;
        else if (AE == 1'b0)
            status <= 1'b0;
        else if (AE == 1'b1 && status == 1'b0) begin
            add[15:0] <= EXT_AD_OUT;
            status <= 1'b1;
        end
        else if (AE == 1'b1 && status == 1'b1)begin
            add[31:16] <= EXT_AD_OUT;
            status <= 1'b0;
        end
    end

    reg [7:0] data;
    always @(negedge AE, posedge rst) begin
        if (rst)
            data <= 8'b0;
        else
            data <= EXT_AD_OUT[7:0];
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
        .cycle(40),
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
        #10;
        rst = 1'b1;
        #100;
        rst = 1'b0;
        #100000000;
        $stop;
    end

endmodule