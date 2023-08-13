/////////////////////////////////////////////
// A simple bus design for interfacing :   //
//     a CPU -> AFTAB                      //
//     a memory -> an SRAM                 //
//     a memory initializer -> Negin's SPI //
// Writer: Amirmahdi Joudi                 //
// Date: 01/08/2023                        //
/////////////////////////////////////////////
`timescale 1ns/1ns
module internalBus (
    input clk,
    input rst,

    input [31:0] MASTER1_ADD,
    input [31:0] MASTER2_ADD,
    output [31:0] SLAVE_ADD,

    output [7:0] MASTER1_DATA_IN,
    output [7:0] MASTER2_DATA_IN,
    output [7:0] SLAVE_DATA_IN,

    input [7:0] MASTER1_DATA_OUT,
    input [7:0] MASTER2_DATA_OUT,
    input [7:0] SLAVE_DATA_OUT,

    input MASTER1_READ,
    input MASTER2_READ,
    output SLAVE_READ,

    input MASTER1_WRITE,
    input MASTER2_WRITE,
    input SPI_request,
    output SLAVE_WRITE,

    output MASTER1_READY,
    output MASTER2_READY,
    input SLAVE_READY
);

    wire [31:0] ADD_BUS;
    wire [7:0] DATA_BUS;
    wire READ_BUS;
    wire WRITE_BUS;

    wire G0;
    wire G1;
    arbiter ARBITER(
        .clk(clk),
        .rst(rst),
        .MASTER1_READ(SPI_request),
        .MASTER2_READ(~SPI_request),
        .MASTER1_WRITE(SPI_request),
        .MASTER2_WRITE(~SPI_request),
        .GRANT0(G0),
        .GRANT1(G1)
    );

    assign ADD_BUS = (G0) ? MASTER1_ADD :
                     (G1) ? MASTER2_ADD :
                     (32'bz);

    assign SLAVE_ADD = (G0 || G1) ? ADD_BUS :
                       (32'bz);

    assign DATA_BUS = (G0) ? ((MASTER1_WRITE) ? MASTER1_DATA_OUT : 8'bz) :
                      (G1) ? ((MASTER2_WRITE) ? MASTER2_DATA_OUT : 8'bz) :
                      (8'bz);

    assign MASTER1_DATA_IN = (G0) ? ((MASTER1_READ) ? SLAVE_DATA_OUT : 8'bz) :
                          (8'bz);

    assign MASTER2_DATA_IN = (G1) ? ((MASTER2_READ) ? SLAVE_DATA_OUT : 8'bz) :
                          (8'bz);

    assign SLAVE_DATA_IN = (G0||G1) ? ((MASTER1_WRITE || MASTER2_WRITE) ? DATA_BUS : 8'bz) :
                        (8'bz);

    assign READ_BUS = (G0) ? MASTER1_READ :
                      (G1) ? MASTER2_READ :
                      (1'b0);

    assign SLAVE_READ = READ_BUS;

    assign WRITE_BUS = (G0) ? MASTER1_WRITE :
                       (G1) ? MASTER2_WRITE :
                       (1'b0);

    assign SLAVE_WRITE = WRITE_BUS;

    assign MASTER1_READY = (G0) ? SLAVE_READY :
                           (1'b0);

    assign MASTER2_READY = (G1) ? SLAVE_READY :
                           (1'b0);

endmodule