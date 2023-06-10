`timescale 1ns/1ns
module interface (
    input clk,
    input rst,
    input AE,
    inout [15:0] EXT_AD,
    input [7:0] memOut,
    input EXT_READY,
    input EXT_read,
    input EXT_write,
    output [13:0] offChipAdd,
    output [7:0] offChipData,
    output EXT_readOutput,
    output EXT_writeOutput,
    output [7:0] DT,
    output [7:0] LEDs,
    output [7:0] LED
);

    assign DT = EXT_READY ? memOut : 8'bzzzzzzzz;
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
    reg [7:0] LED4;
    reg [7:0] LED1;
    reg [7:0] dt;
    always @(negedge AE, posedge rst) begin
        if (rst)
            data <= 8'b0;
        else if (EXT_read == 1'b1 && add == 32'h1A100004)
            dt[7:0] <= LED4;
        else if (EXT_read == 1'b1 && add == 32'h1A100008)
            dt[7:0] <= LED1;
        else
            data <= EXT_AD[7:0];
    end
    assign EXT_AD[7:0] = (EXT_read == 1'b1 && AE == 1'b0 && (add == 32'h1A100004 || add == 32'h1A100008)) ? dt : 8'bzzzzzzzz;

    always @(data) begin
        if (add == 32'h1A100004)
            LED4 <= data;
    end
	assign LEDs = LED4;

    always @(data) begin
        if (add == 32'h1A100008)
            LED1 <= data;
    end
	assign LED = LED1;

    wire offEn;
    wire IOEn;
    assign IOEn = ((add[31:20] == 12'h1A1) & (add[19:17] == 3'b000));
    assign offEn = ({|{add[31:12]}}) & (IOEn == 1'b0);

    assign offChipAdd = add[13:0];
    assign offChipData = data;
    assign EXT_readOutput = EXT_read & offEn;
    assign EXT_writeOutput = EXT_write & offEn;

endmodule