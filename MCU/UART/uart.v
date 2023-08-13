`timescale 1ns/1ns
module uart(
    input [31:0] CLKS_PER_BIT,
    input       ld_CLKS_PER_BIT,
    input       i_Clock,
	input		 rst,
    input       i_Tx_DV, // start by 1 value
    input [7:0] i_Tx_Byte, // must be set simultanously with start
    output      o_Tx_Active, // it is issued when transmit is happening
    output      o_Tx_Serial, // serial tx port
    output      o_Tx_Done, // it is issued when a transmission is compeleted for one cycle.

    input        i_Rx_Serial, // serial rx port
    output       o_Rx_DV, // it is issued when one receiving is compeleted for one cycle
    output [7:0] o_Rx_Byte
);

	reg [1:0] start;
    wire i_Tx_DV_reg;

	always @(posedge i_Clock, posedge rst) begin
		if(rst)
			start <= 2'b00;
		else
			start <={start[0], i_Tx_DV};
	end
	assign i_Tx_DV_reg = (start == 2'b01) ? 1'b1 : 1'b0;

    uart_tx UART_TX_INST(
        .CLKS_PER_BIT(CLKS_PER_BIT),
        .ld_CLKS_PER_BIT(ld_CLKS_PER_BIT),
        .i_Clock(i_Clock),
		  .rst(rst),
        .i_Tx_DV(i_Tx_DV_reg), // start by 1 value
        .i_Tx_Byte(i_Tx_Byte), // must be set simultanously with start
        .o_Tx_Active(o_Tx_Active), // it is issued when transmit is happening
        .o_Tx_Serial(o_Tx_Serial), // serial tx port
        .o_Tx_Done(o_Tx_Done) // it is issued when a transmission is compeleted for one cycle.
    );


    uart_rx UART_RX_INST(
        .CLKS_PER_BIT(CLKS_PER_BIT),
        .ld_CLKS_PER_BIT(ld_CLKS_PER_BIT),
        .i_Clock(i_Clock),
		  .rst(rst),
        .i_Rx_Serial(i_Rx_Serial), // serial rx port
        .o_Rx_DV(o_Rx_DV), // it is issued when one receiving is compeleted for one cycle
        .o_Rx_Byte(o_Rx_Byte)
    );

endmodule