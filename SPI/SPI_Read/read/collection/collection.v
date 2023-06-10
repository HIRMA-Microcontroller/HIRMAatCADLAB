`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2023 10:04:41 AM
// Design Name: 
// Module Name: fifo
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



module collection(
	input clk,
    input rst,
	
	input read,
	input write,
	
	
	input [7:0] numByte_read_wp,
	input [23:0] address_wp,
	
	input direct_fifo,
	input [7:0] direct_buf_in,
	output [7:0] direct_buf_out,
	input direct_wr_en_buf,
	input direct_rd_en_buf,
	
	
	input DO,
	output DI,
	output SCK,
	output CSbar
	
);



	
	
	wire wren;
	wire rden;
	
	wire [7:0] buf_in, buf_out;
	
	wire valid_from_flash; // valid
	
	wire [7:0] command;  // command
	wire [23:0] address; // address
	
	wire valid_to_flash; // valid_in
	wire last_to_flash; // last_in
	
	wire [7:0] numByte_read; // numByte_read
	
	wire ready_from_flash; // ready_in
	
	wire [7:0] flash_to_buf_data; // data_out
	wire [7:0] buf_to_flash_data;  // data_in
	
	
	// buffer
	
	wire [7:0] flash_to_buf_data_wp; // buf_out
	wire [7:0] buf_to_flash_data_wp; // buf_in
	wire wr_en_buf;
	wire rd_en_buf; 
	wire buf_empty; 
	wire buf_full;







wrapper wrapper_inst(

	.clk(clk),
    .rst(rst),
	
	.read(read),
	.write(write),
	
	
	.numByte_read_wp(numByte_read_wp),
	.address_wp(address_wp),
	
	
	// flash_cms
	
	.CSbar(CSbar), // CSbar
	
	.valid_from_flash(valid_from_flash), // valid
	
	.command(command),  // command
	.address(address), // address
	
	.valid_to_flash(valid_to_flash), // valid_in
	.last_to_flash(last_to_flash),  // last_in
	
	.numByte_read(numByte_read), // numByte_read
	
	.ready_from_flash(ready_from_flash), // ready_in
	
	.flash_to_buf_data(flash_to_buf_data), // data_out
	.buf_to_flash_data(buf_to_flash_data),  // data_in
	
	
	// buffer
	
	.flash_to_buf_data_wp(flash_to_buf_data_wp), // buf_out
	.buf_to_flash_data_wp(buf_to_flash_data_wp), // buf_in
	.wr_en_buf(wr_en_buf), 
	.rd_en_buf(rd_en_buf), 
	.buf_empty(buf_empty), 
	.buf_full(buf_full)


);


fifo #(4) fifo_inst( 
	.clk(clk), 
	.rst(rst), 
	.buf_in(buf_in), 
	.buf_out(buf_out), 
	.wr_en(wren),
	.rd_en(rden),
	.buf_empty(buf_empty),
	.buf_full(buf_full)
);
	

	
	assign buf_in = (direct_fifo) ? direct_buf_in : flash_to_buf_data;
	
	assign direct_buf_out = (direct_fifo) ? buf_out : 8'bz; 
	
	assign buf_to_flash_data = (~direct_fifo) ? buf_out : 8'bz; 
	
	assign wren = (direct_fifo) ? direct_wr_en_buf : wr_en_buf;
    assign rden = (direct_fifo) ? direct_rd_en_buf : rd_en_buf;

flash_cms flash_cms_inst(

    .clk(clk),
    .rst(rst),
	.command(command),
	.data_in(buf_to_flash_data_wp),
	.address(address),
	
	.valid_in(valid_to_flash),
	.last_in(last_to_flash),
	
	.numByte_read(numByte_read),
	
	.ready_in(ready_from_flash), 

    // spi interface
    .DO(DO),
    .DI(DI),
    .SCK(SCK),
    .CSbar(CSbar),
	
	.data_out(flash_to_buf_data_wp ),
	.valid(valid_from_flash)
);




endmodule