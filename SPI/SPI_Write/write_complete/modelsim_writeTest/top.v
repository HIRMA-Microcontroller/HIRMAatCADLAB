`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2023 11:05:04 AM
// Design Name: 
// Module Name: top_cms
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
	input 		clk,
    input 		rst,


    // spi interface
    input 		DO,
    output  	DI,
    output  	SCK,
    output  	CSbar

    );
	
	parameter fifo_depth = 2000;
	
	wire read;
	wire write;
	
	
	wire [7:0] numByte_read_wp;
	wire [23:0] address_wp;
	
	wire direct_fifo, clk_in;
	wire [7:0] direct_buf_in;
	wire [7:0] direct_buf_out;
	wire direct_wr_en_buf;
	wire direct_rd_en_buf;
	wire [31:0] numByte_write;
	
	wire start;

	collection #(fifo_depth) collection_inst (
		.clk(clk_in),
		.rst(rst),
		
		.read(read),
		.write(write),
		
		
		.numByte_read_wp(numByte_read_wp),
		.numByte_write(numByte_write),
		.address_wp(address_wp),
		
		.direct_fifo(direct_fifo),
		.direct_buf_in(direct_buf_in),
		.direct_buf_out(direct_buf_out),
		.direct_wr_en_buf(direct_wr_en_buf),
		.direct_rd_en_buf(direct_rd_en_buf),
		
		
		.DO(DO),
		.DI(DI),
		.SCK(SCK),
		.CSbar(CSbar)
	);
	
	auto_fifo_fill #(fifo_depth) auto_fifo_fill_inst(
	    .clk(clk_in),
	    .rst(rst),
	    .start(start),
	    .direct_fifo(direct_fifo),
	    .direct_buf_in(direct_buf_in),
		.direct_wr_en_buf(direct_wr_en_buf)
    );
	
	
	
	
	
	
	vio_0 vio_0_inst(
		.clk		(clk_in				),	
		.probe_out0	(read				),
		.probe_out1	(write				),
		.probe_out2	(start				),
		.probe_out3	(numByte_read_wp	),
		.probe_out4	(address_wp			),
		.probe_out5	(numByte_write		)
	);
	
	
	clk_wiz_0 clk_wiz_0_inst (
        .clk_out1	(clk_in		),
        .clk_in1	(clk		)
	);
	
	
endmodule
