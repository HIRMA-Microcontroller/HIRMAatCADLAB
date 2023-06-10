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



module collection 
#(parameter fifo_depth = 2000)
(
	input 			clk						,
    input 			rst						,
	input 			read					,
	input 			write					,
	input 	[7:0] 	numByte_read_wp			,
	input	[31:0]	numByte_write			,
	input 	[23:0] 	address_wp				,
	input 			direct_fifo				,
	input 	[7:0] 	direct_buf_in			,
	output 	[7:0] 	direct_buf_out			,
	input 			direct_wr_en_buf		,
	input 			direct_rd_en_buf		,
	input 			DO						,
	output 			DI						,
	output 			SCK						,
	output 			CSbar
);



	wire [4:0] ps, ns;
	
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
	
	reg [31:0]	numByte_write_reg;
	
	// buffer
	
	wire [7:0] flash_to_buf_data_wp; // buf_out
	wire [7:0] buf_to_flash_data_wp; // buf_in
	wire wr_en_buf;
	wire rd_en_buf; 
	wire buf_empty; 
	wire buf_full;
	
	reg [1:0] w_rec, r_rec;
	
	reg write_in, read_in;
	
	reg [7:0] 	numByte_read_wp_reg	;		
	reg [23:0] 	address_wp_reg		;		
	
	
	// debouncer
	always @(posedge clk) begin
		w_rec <= {w_rec[0], write};
		r_rec <= {r_rec[0], read};
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
		if((write == 1) || (read == 1)) begin
			address_wp_reg	<= address_wp;
			numByte_read_wp_reg <= numByte_read_wp;
			numByte_write_reg <= numByte_write;
		end
		else begin
			address_wp_reg	<= address_wp_reg;
			numByte_read_wp_reg <= numByte_read_wp_reg;
			numByte_write_reg <= numByte_write_reg;
		end
	
	end
	
	////
	
	
	// ila_0 ila_0_inst(
		// .clk			(clk					),


		// .probe0			(rst					),
		// .probe1			(read_in				),
		// .probe2			(write_in				),
		
		// .probe3			(direct_fifo			),
		// .probe4			(direct_wr_en_buf		),
		// .probe5			(direct_rd_en_buf		),
		// .probe6			(DO						),
		// .probe7			(DI						),
		// .probe8			(SCK					),
		// .probe9			(CSbar					),
		// .probe10		(wren					),
		// .probe11		(rden					),
		// .probe12		(valid_from_flash		),
		// .probe13		(valid_to_flash			),
		// .probe14		(last_to_flash			),
		// .probe15		(ready_from_flash		),
		// .probe16		(wr_en_buf				),
		// .probe17		(rd_en_buf				),
		// .probe18		(buf_empty				),
		// .probe19		(buf_full				),
		// .probe20		(numByte_read_wp_reg	),
		// .probe21		(direct_buf_in			),
		// .probe22		(direct_buf_out			),
		// .probe23		(buf_in					),
		// .probe24		(buf_out				),
		// .probe25		(command				),
		// .probe26		(numByte_read			),
		// .probe27		(flash_to_buf_data		),
		// .probe28		(buf_to_flash_data		),
		// .probe29		(flash_to_buf_data_wp	),
		// .probe30		(buf_to_flash_data_wp	),
		// .probe31		(address				),
		// .probe32		(ns),
		// .probe33		(ps)
	// );
	
	
	
	
	
	







wrapper wrapper_inst(

	.clk(clk),
    .rst(rst),
	
	.read(read_in),
	.write(write_in),
	
	
	.numByte_read_wp(numByte_read_wp_reg),
	.numByte_write	(numByte_write_reg),
	.address_wp		(address_wp_reg		),
	
	.ps(ps),
	.ns(ns),
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


fifo #(fifo_depth) fifo_inst( 
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