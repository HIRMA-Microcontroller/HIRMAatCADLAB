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
	
	wire read;
	wire write;
	
	
	wire [7:0] numByte_read_wp;
	wire [23:0] address_wp;
	
	wire direct_fifo, clk_in, rden;
	wire [7:0] buf_out;
	wire buf_full;
	wire buf_empty;
	
	

	collection  collection_inst (
		.clk(clk_in),
		.rst(rst),
		
		.read(read),
		.write(write),
		
		
		.numByte_read_wp(numByte_read_wp),
		.address_wp(address_wp),
		
		.buf_empty(buf_empty),
		.buf_full(buf_full),
		.buf_out(buf_out),
		.rden(rden),
		
		
		
		.DO(DO),
		.DI(DI),
		.SCK(SCK),
		.CSbar(CSbar)
	);
	
	
	
	
	
	
	
	vio_0 vio_0_inst(
		.clk		(clk_in				),	
		.probe_out0	(read				),
		.probe_out1	(write				),
		.probe_out2	(rden				),
		.probe_out3	(numByte_read_wp	),
		.probe_out4	(address_wp			)
	);
	
	
	clk_wiz_0 clk_wiz_0_inst (
        .clk_out1	(clk_in		),
        .clk_in1	(clk		)
	);
	
	
endmodule
