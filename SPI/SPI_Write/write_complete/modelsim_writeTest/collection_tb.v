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



module collection_tb ();




	reg clk = 0;
  reg rst;
	
	reg read;
	reg write;
	
	
	reg [7:0] numByte_read_wp;
	reg [23:0] address_wp;
	reg [31:0] numByte_write;
	
	wire direct_fifo;
	wire [7:0] direct_buf_in;
	wire [7:0] direct_buf_out;
	wire direct_wr_en_buf;
	wire direct_rd_en_buf;
	
	
	reg DO;
	wire DI;
	wire SCK;
	wire CSbar;
	
	reg start;
	

	collection #(5000)  collection_inst (
		.clk(clk),
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
	
	
	auto_fifo_fill #(5000) auto_fifo_fill_inst(
	    .clk(clk),
	    .rst(rst),
	    .start(start),
	    .direct_fifo(direct_fifo),
	    .direct_buf_in(direct_buf_in),
		.direct_wr_en_buf(direct_wr_en_buf)
    );
	
	
	initial repeat (1000000) #5 clk = ~clk;
	
	initial begin
	  numByte_write = 0;
		start = 0;
		DO = 0;
		read = 0;
		write = 0;
		rst = 1;
		#22;
		rst = 0;
		#20;
		start = 1;
		#10;
		start = 0;
		#200;
		
		#50500;
		
		write = 1;
		address_wp = 24'd0;
		numByte_write = 5000;
		
		#10;
		
		
		write = 0;
		address_wp = 24'd0;
		numByte_write = 0;
		#2000;
		DO = 1;
		
		
		
		
		#10000;
		
		
		
		#1500;
		DO = 1;
		
		#1000;
		
		#5000;
		
	
	
	end
	

	



endmodule