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



module FLASH_Controller (
	input 			clk						,
    input 			rst						,

	// flash wrapper interface //
	input 			read					,
	input			read_chunk				,
	input 			write					,
	input 	[7:0] 	numByte_read_wp			,
	input 	[23:0] 	address_wp				,
	////////////////////////////

	// fifo interface //
	output 	[7:0] 	buf_out					,
	input 			rden					,
	output			buf_empty				,
	output			buf_full				,
	////////////////////

	// spi interface //
	input 			DO						,
	output 			DI						,
	output 			SCK						,
	output 			CSbar
	//////////////////
);


	parameter CHUNK_DEPTH = 16;


	wire wren;

	wire [7:0] buf_in;

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


	reg [1:0] w_rec, r_rec, rc_rec;

	reg write_in, read_in, read_chunk_in;

	reg [7:0] 	numByte_read_wp_reg	;
	reg [23:0] 	address_wp_reg		;


	// debouncer
	always @(posedge clk) begin
		w_rec <= {w_rec[0], write};
		r_rec <= {r_rec[0], read};
		rc_rec <= {rc_rec[0], read_chunk};
	end

	always @(posedge clk) begin
		if(w_rec == 2'b01) begin
			write_in <= 1;
		end
		else
			write_in <= 0;
	end

	always @(posedge clk) begin
		if(r_rec == 2'b01) begin
			read_in <= 1;
		end
		else
			read_in <= 0;
	end

	always @(posedge clk) begin
		if(rc_rec == 2'b01) begin
			read_chunk_in <= 1;
		end
		else
			read_chunk_in <= 0;
	end

	always @(posedge clk) begin
		if((write == 1) || (read == 1) || (read_chunk == 1)) begin
			address_wp_reg	<= address_wp;
			numByte_read_wp_reg <= numByte_read_wp;
		end
		else begin
			address_wp_reg	<= address_wp_reg;
			numByte_read_wp_reg <= numByte_read_wp_reg;
		end

	end

	////
	wire res1;
	wire res2;
	wire [7:0] res3, res4;

	assign res1 = 0;
	assign res2 = 0;
	assign res3 = 0;
	assign res4 =0;

    wire [7:0] full_numByte, cnt_RB;

	// ila_0 ila_0_inst(
	// 	.clk			(clk					),


	// 	.probe0			(rst					),
	// 	.probe1			(read_in				),
	// 	.probe2			(read_chunk_in			),

	// 	.probe3			(read					), //
	// 	.probe4			(read_chunk				), //
	// 	.probe5			(res1					), //
	// 	.probe6			(DO						),
	// 	.probe7			(DI						),
	// 	.probe8			(SCK					),
	// 	.probe9			(CSbar					),
	// 	.probe10		(wren					),
	// 	.probe11		(rden					),
	// 	.probe12		(valid_from_flash		),
	// 	.probe13		(valid_to_flash			),
	// 	.probe14		(last_to_flash			),
	// 	.probe15		(ready_from_flash		),
	// 	.probe16		(wr_en_buf				),
	// 	.probe17		(rd_en_buf				),
	// 	.probe18		(buf_empty				),
	// 	.probe19		(buf_full				),
	// 	.probe20		(numByte_read_wp_reg	),
	// 	.probe21		(cnt_RB					), //
	// 	.probe22		(full_numByte			), //
	// 	.probe23		(buf_in					),
	// 	.probe24		(buf_out				),
	// 	.probe25		(command				),
	// 	.probe26		(numByte_read			),
	// 	.probe27		(flash_to_buf_data		),
	// 	.probe28		(buf_to_flash_data		),
	// 	.probe29		(flash_to_buf_data_wp	),
	// 	.probe30		(buf_to_flash_data_wp	),
	// 	.probe31		(address				),
	// 	.probe32		(ns),
	// 	.probe33		(ps)
	// );








wrapper #(CHUNK_DEPTH) wrapper_inst(

	.clk(clk),
    .rst(rst),

	.read(read_in),
	.read_chunk(read_chunk_in),
	.write(write_in),


	.numByte_read_wp(numByte_read_wp_reg),
	.address_wp		(address_wp_reg		),

	.full_numByte(full_numByte),
	.cnt_RB(cnt_RB),

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


fifo #(CHUNK_DEPTH) fifo_inst(
	.clk(clk),
	.rst(rst),
	.buf_in(buf_in),
	.buf_out(buf_out),
	.wr_en(wren),
	.rd_en(rden),
	.buf_empty(buf_empty),
	.buf_full(buf_full)
);



	assign buf_in = flash_to_buf_data;

	//assign direct_buf_out = (direct_fifo) ? buf_out : 8'bz;

	assign buf_to_flash_data = 8'bz; //(~direct_fifo) ? buf_out : 8'bz;

	assign wren = wr_en_buf;
   // assign rden = (direct_fifo) ? direct_rd_en_buf : rd_en_buf;

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