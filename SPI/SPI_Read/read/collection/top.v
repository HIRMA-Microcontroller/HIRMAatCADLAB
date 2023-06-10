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
	
	wire [7:0] command;
	
	wire valid;
	
	
	flash_cms flash_cms_inst(
		.clk		(clk		),
		.rst		(rst		),
		.command	(command	),
		.DO			(DO			),
		.DI			(DI			),
		.SCK		(SCK		),
		.CSbar		(CSbar		),
		.valid      (valid   	)
	);
	
	vio_0 vio_0_inst(
		.clk		(clk		),	
		.probe_out0	(command	)
	);
	
	
endmodule
