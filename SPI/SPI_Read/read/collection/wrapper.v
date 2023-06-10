`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2023 08:43:16 AM
// Design Name: 
// Module Name: wrapper
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


module wrapper(

	input clk,
    input rst,
	
	input read,
	input write,
	
	
	input [7:0] numByte_read_wp,
	input [23:0] address_wp,
	
	
	// flash_cms
	
	input CSbar, // CSbar
	
	input valid_from_flash, // valid
	
	output reg [7:0] command,  // command
	output reg [23:0] address, // address
	
	output reg valid_to_flash, // valid_in
	output 		last_to_flash,  // last_in
	
	output reg [7:0] numByte_read, // numByte_read
	
	input ready_from_flash, // ready_in
	
	output [7:0] flash_to_buf_data, // data_out
	input [7:0] buf_to_flash_data,  // data_in
	
	
	// buffer
	
	input [7:0] flash_to_buf_data_wp, // buf_out
	output [7:0] buf_to_flash_data_wp, // buf_in
	output reg  wr_en_buf, 
	output reg  rd_en_buf, 
	input buf_empty, 
	input buf_full


);
	
	
	
	localparam [7:0] READ_STATUS = 8'h05,
					 WRITE_STATUS = 8'h01,
					 WRITE_ENABLE = 8'h06,
					 PAGE_PROGRAM = 8'h02,
					 READ_DATA = 8'h03,
					 SECTOR_ERASE = 8'h20;
	
	
	localparam [4:0] IDLE 	= 0,
					 ERASE1 = 1,
					 ERASE2 = 2,
					 PAGEP1 = 3,
					 PAGEP2 = 4,
					 SENDD 	= 5,
					 END	= 6,
					 WRE1	= 7,
					 WRE2	= 8,
					 RDST1	= 9,
					 RDST2	= 10,
					 STCHCK = 11,
					 READD1	= 12,
					 READD2 = 13;
					 
	
	reg valid_to_flash_reg; // last_to_flash_reg;
	
	reg flag;
	
	reg ld_adr, ld_numBread;
	
	reg [7:0] status_reg; 
	
	reg [4:0] ps, ns;
	
	always @(posedge clk) begin
		if(rst) 
			ps <= IDLE;
		else
			ps <= ns;
	end
	
	always @(ps, read, write, CSbar, buf_empty, valid_from_flash) begin
		case(ps)
			IDLE 	: ns = (write == 1) ? WRE1 :
						   (read == 1) ? READD1 : IDLE;
			
		    ERASE1  : ns = (CSbar == 1) ? ERASE2 : ERASE1;
			
		    ERASE2  : ns = (CSbar == 1) ? WRE1 : ERASE2;
			
		    PAGEP1  : ns = (CSbar == 1) ? PAGEP2 : PAGEP1;
			
		    PAGEP2  : ns = (CSbar == 0) ? SENDD : PAGEP2;
			
		    SENDD 	: ns = (buf_empty == 1) ? END : SENDD;
			
		    END	    : ns = (CSbar == 1) ? IDLE : END;
			
		    WRE1	: ns = (CSbar == 1) ? WRE2 : WRE1;
			
		    WRE2	: ns = (CSbar == 1) ? RDST1 : WRE2;
			
		    RDST1	: ns = (CSbar == 1) ? RDST2 : RDST1;
			
		    RDST2	: ns = (CSbar == 1) ? STCHCK : RDST2;
			
		    STCHCK  : ns = ((status_reg[1]) && (~flag)) ? ERASE1 :
						   ((status_reg[1]) && (flag)) ? PAGEP1 : WRE1;
			
			READD1	: ns = (CSbar == 1) ? READD2 : READD1;
			
			READD2	: ns = (((CSbar == 1) && (valid_from_flash == 0)) || (buf_full == 1)) ? IDLE : READD2;
			
			default : ns = IDLE;
			
		endcase
	end
	
	always @(ps, read, write, CSbar, buf_empty, ready_from_flash, valid_from_flash, buf_full) begin
		command = 0;
		ld_adr = 0;
		valid_to_flash_reg = 0;
		rd_en_buf = 0;
		wr_en_buf = 0;
		ld_numBread = 0;		
		//last_to_flash_reg = 0;
		
		case(ps)
			 IDLE 	: begin 
				ld_adr = 1; 
				ld_numBread = 1;
			end
			
		    ERASE1  : begin
				if(CSbar) 
					command = SECTOR_ERASE;
				//ld_adr = 1;
			end
			
		    ERASE2  : begin
				command = 0;
			end
			
		    PAGEP1  : begin
				if(CSbar) 
					command = PAGE_PROGRAM;
				//ld_adr = 1;
			end
			
		    PAGEP2  : begin
				command = 0;
			end
			
		    SENDD 	: begin
				if(CSbar == 0) begin
					if(ready_from_flash == 1) begin
						valid_to_flash_reg = 1;
						rd_en_buf = 1;
						
						// if(buf_empty == 1) begin
							// last_to_flash_reg = 1;
						// end
						
					end
				end
				
			end
			
		    END	    : begin
						
			end
			
		    WRE1	: begin
				if(CSbar == 1)
					command = WRITE_ENABLE;			
			end
			
		    WRE2	: begin
				command = 0;
			end
			
		    RDST1	: begin
				if(CSbar == 1)
					command = READ_STATUS;	
			end
			
		    RDST2	: begin
				command = 0;
			end
			
		    STCHCK  : begin
						
			end
			
			READD1	: begin
				if(CSbar == 1)
					command = READ_DATA;		
			end
			
			READD2	: begin
				command = 0;
				if((buf_full == 0) && (valid_from_flash == 1))
					wr_en_buf = 1;		
			end
	
		endcase
	end
	
	
	always @(posedge clk) begin
		if(ps == IDLE)
			flag <= 0;
		else if(ps == ERASE2)
			flag <= 1;
		else
			flag <= flag;
	end
	
	
	always @(posedge clk) begin
		valid_to_flash <= valid_to_flash_reg;
		//last_to_flash <= last_to_flash_reg;
	end
	
	assign last_to_flash = buf_empty;
	
	always @(posedge clk) begin
		if(rst)
			address <= 0;
		else if(ld_adr)
			address <= address_wp;
		else
			address <= address;
	end

	
	always @(posedge clk) begin
		if(rst)
			address <= 0;
		else if(ld_numBread)
			numByte_read <= numByte_read_wp;
		else
			numByte_read <= numByte_read;
	end
	
	
	
	always @(posedge clk) begin
		if(rst)
			status_reg <= 0;
		else if((ps == 10) && valid_from_flash)
			status_reg <= flash_to_buf_data_wp;
		else if((ps == WRE1) || (ps == ERASE1) ||(ps == PAGEP1))
			status_reg <= 0;
		else 
			status_reg <= status_reg;
	end

	
	
	assign flash_to_buf_data = flash_to_buf_data_wp;
	assign buf_to_flash_data_wp = buf_to_flash_data;
	
	
endmodule
