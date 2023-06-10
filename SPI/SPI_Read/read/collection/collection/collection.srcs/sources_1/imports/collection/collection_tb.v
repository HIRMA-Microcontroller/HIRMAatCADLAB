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
	
	reg direct_fifo;
	reg [7:0] direct_buf_in;
	wire [7:0] direct_buf_out;
	reg direct_wr_en_buf;
	reg direct_rd_en_buf;
	
	
	reg DO;
	wire DI;
	wire SCK;
	wire CSbar;
	

	collection  collection_inst (
		.clk(clk),
		.rst(rst),
		
		.read(read),
		.write(write),
		
		
		.numByte_read_wp(numByte_read_wp),
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
	
	initial repeat (20000) #5 clk = ~clk;
	
	initial begin
		direct_fifo = 0;
		direct_rd_en_buf = 0;
		DO = 0;
		read = 0;
		write = 0;
		rst = 1;
		#22;
		rst = 0;
		#20;
		#200;
		
		direct_fifo = 1;
		
		
		direct_wr_en_buf = 1;
		direct_buf_in = 10;
		#10;
		direct_wr_en_buf = 0;
		#30;
		
		direct_wr_en_buf = 1;
		direct_buf_in = 11;
		#10;
		direct_wr_en_buf = 0;
		#30;
		
		direct_wr_en_buf = 1;
		direct_buf_in = 12;
		#10;
		direct_wr_en_buf = 0;
		#30;
		
		direct_wr_en_buf = 1;
		direct_buf_in = 13;
		#10;
		direct_wr_en_buf = 0;
		#30;
		
		
		#500;
		direct_fifo = 0;
		
		write = 1;
		address_wp = 24'd2;
		
		#10;
		
		
		write = 0;
		address_wp = 24'd0;
		#2000;
		DO = 1;
		
		
		
		
		#10000;
		
		read = 1;
		address_wp = 24'd2;
		numByte_read_wp = 2;
		#10;
		
		
		read = 0;
		address_wp = 24'd0;
		numByte_read_wp = 0;
		
		#1500;
		DO = 0;
		
		#1000;
		
		#5000;
		direct_fifo = 1;
		direct_rd_en_buf = 1;
		
	
	
	end
	

	



endmodule