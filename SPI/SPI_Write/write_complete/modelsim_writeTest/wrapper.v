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
	
	output reg [4:0] ps, ns,
	
	
	input [7:0] numByte_read_wp,
	input [31:0] numByte_write,
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
	
	parameter PAGE_DEPTH = 4096;
	localparam [27:0] WAIT_LIMIT = 28'd100; // d100000000
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
	reg wr_flg;
	reg ld_adr, ld_numBread;
	
	reg [7:0] status_reg; 
	
	reg [27:0] wait_cnt;
	wire init_wait_cnt;
	reg cen_wait_cnt;
	
	reg inc256_address, cen_writeNum;
	reg [31:0] cnt_writeNum, writeNum;
	wire ld_writeNum, end_page;
	reg page_full;
	reg [1:0] end_page_mem;
	
	assign end_page = ((((cnt_writeNum % PAGE_DEPTH) == 0) && (cnt_writeNum != 0)) || ((writeNum == cnt_writeNum) && (writeNum != 0))) ? 1 : 0;
	assign last_to_flash = end_page;
	assign ld_writeNum = write;
	assign init0_writeNum = ((writeNum == cnt_writeNum) && (writeNum != 0)) ? 1 : 0;
	always @(posedge clk) begin
		if(rst || init0_writeNum) begin
			cnt_writeNum <= 0;
			writeNum <= 0;
			end_page_mem <= 0;
		end
		else if(ld_writeNum)
			writeNum <= numByte_write;
		else if(cen_writeNum)
			cnt_writeNum <= cnt_writeNum + 1;
		else begin
			cnt_writeNum <= cnt_writeNum;
			writeNum <= writeNum;
		end
		
		end_page_mem <= {end_page_mem[0], end_page};
		if(end_page_mem == 2'b01)
			page_full <= 1;
		else
			page_full <= 0;
	
	end
	
	always @(posedge clk) begin
		if(rst)
			wr_flg <= 0;
		else if(init0_writeNum)
			wr_flg <= 0;
		else if(page_full)
			wr_flg <= 1;
		else
			wr_flg <= wr_flg;
		
	end
	
	
	//reg [4:0] ps, ns;
	
	always @(posedge clk) begin
		if(rst) 
			ps <= IDLE;
		else
			ps <= ns;
	end
	
	always @(ps, read, write, CSbar, buf_empty, valid_from_flash, wait_cnt, page_full) begin
		case(ps)
			IDLE 	: ns = (write == 1) ? WRE1 :
						   (read == 1) ? READD1 : IDLE;
			
		    ERASE1  : ns = (wait_cnt == WAIT_LIMIT) ? ERASE2 : ERASE1; // (CSbar == 1)
			
		    ERASE2  : ns = (CSbar == 1) ? WRE1 : ERASE2;
			
		    PAGEP1  : ns = (wait_cnt == WAIT_LIMIT) ? PAGEP2 : PAGEP1; // (CSbar == 1)
			
		    PAGEP2  : ns = (CSbar == 0) ? SENDD : PAGEP2;
			
		    SENDD 	: ns = (buf_empty == 1) ? END :
						   (page_full == 1) ? WRE1 : SENDD;
			
		    END	    : ns = (CSbar == 1) ? IDLE : END;
			
		    WRE1	: ns = (wait_cnt == WAIT_LIMIT) ? WRE2 : WRE1; //  (CSbar == 1)
			
		    WRE2	: ns = (CSbar == 1) ? RDST1 : WRE2;
			
		    RDST1	: ns = (wait_cnt == WAIT_LIMIT) ? RDST2 : RDST1; // (CSbar == 1) 
			
		    RDST2	: ns = (CSbar == 1) ? STCHCK : RDST2;
			
		    STCHCK  : ns = ((status_reg[1]) && (~flag) ) ? ERASE1 :
						   ((status_reg[1]) && (flag)) ? PAGEP1 : WRE1;
			
			READD1	: ns = (CSbar == 1) ? READD2 : READD1;
			
			READD2	: ns = (((CSbar == 1) && (valid_from_flash == 0)) || (buf_full == 1)) ? IDLE : READD2;
			
			default : ns = IDLE;
			
		endcase
	end
	
	always @(ps, read, write, CSbar, buf_empty, ready_from_flash, valid_from_flash, buf_full, page_full) begin
		command = 0;
		ld_adr = 0;
		valid_to_flash_reg = 0;
		rd_en_buf = 0;
		wr_en_buf = 0;
		ld_numBread = 0;
		cen_wait_cnt = 0;
		inc256_address = 0;	
		cen_writeNum = 0;
		//init_wait_cnt = 0;		
		//last_to_flash_reg = 0;
		
		case(ps)
			 IDLE 	: begin 
				ld_adr = 1; 
				ld_numBread = 1;
				//init_wait_cnt = 1;
			end
			
		    ERASE1  : begin
				if(CSbar) begin
					command = SECTOR_ERASE;
					cen_wait_cnt = 1;
				end
				//ld_adr = 1;
			end
			
		    ERASE2  : begin
				command = 0;
				//init_wait_cnt = 1;
			end
			
		    PAGEP1  : begin
				if(CSbar) begin
					command = PAGE_PROGRAM;
					cen_wait_cnt = 1;
				end
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
						cen_writeNum = 1;
						// if(buf_empty == 1) begin
							// last_to_flash_reg = 1;
						// end
						
					end
				end
				if (page_full == 1) begin
					inc256_address = 1;
				end
				
			end
			
		    END	    : begin
						
			end
			
		    WRE1	: begin
				if(CSbar == 1) begin
					command = WRITE_ENABLE;	
					cen_wait_cnt = 1;
				end					
			end
			
		    WRE2	: begin
				command = 0;
			end
			
		    RDST1	: begin
				if(CSbar == 1) begin
					command = READ_STATUS;
					cen_wait_cnt = 1;
				end	
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
		if((ps == IDLE) || (ps == PAGEP1))
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
	
	//assign last_to_flash = buf_empty;
	
	always @(posedge clk) begin
		if(rst)
			address <= 0;
		else if(ld_adr)
			address <= address_wp;
		else if(inc256_address)
			address <= address + 256;
		else
			address <= address;
	end

	
	always @(posedge clk) begin
		if(rst)
			numByte_read <= 0;
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
	
	
	
	always @(posedge clk) begin
		if(rst) 
			wait_cnt <= 0;
		else if(init_wait_cnt)
			wait_cnt <= 0;
		else if(cen_wait_cnt)
			wait_cnt <= wait_cnt + 1;
		else
			wait_cnt <= wait_cnt;
			
	
	end
	
	assign init_wait_cnt = (wait_cnt == WAIT_LIMIT) ? 1 : 0;

	
	
	assign flash_to_buf_data = flash_to_buf_data_wp;
	assign buf_to_flash_data_wp = buf_to_flash_data;
	
	
endmodule
