`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2023 09:44:24 AM
// Design Name: 
// Module Name: flash_cms
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


module flash_cms(

    input clk,
    input rst,
	input [7:0] command,
	input [7:0] data_in,
	input [23:0] address,
	
	input valid_in,
	input last_in,
	
	input [7:0] numByte_read,
	
	output reg ready_in,

    // spi interface
    input DO,
    output reg DI,
    output reg SCK,
    output reg CSbar,
	
	output [7:0] data_out,
	output reg valid
);

	localparam [7:0] READ_STATUS = 8'h05,
					 WRITE_STATUS = 8'h01,
					 WRITE_ENABLE = 8'h06,
					 PAGE_PROGRAM = 8'h02,
					 READ_DATA = 8'h03,
					 SECTOR_ERASE = 8'h20;

    localparam [2:0] IDLE = 3'b000,
                     WAIT = 3'b001,
                     SEND_OP = 3'b010,
                     GET_DATA = 3'b011,
					 SEND_DATA = 3'b100,
					 SEND_ADDRESS = 3'b101,
					 WAIT_FOR_DIN = 3'b110;
					 

    reg [2:0] ps, ns;
	
	reg [7:0] Sreg;
	reg [7:0] Dreg;
	reg [7:0] command_reg, data_in_reg, numByte_read_reg;
	
	reg [23:0] address_reg;

    reg valid_reg; 
	
	reg last_in_reg;
	
	reg shiftAdr;
	
	reg loadDI;
	
	reg shiftS, loadS;
	reg shiftD;
	
    reg BitInit;
    reg BitCntEn;
    wire[31:0] BitCnt;
    counter #(.width(32)) bitCounter(
        .clk(clk),
        .rst(rst),
        .init(BitInit),
        .cntEn(BitCntEn),
        .cnt(BitCnt)
    );

    // reg ByteInit;
    // reg ByteCntEn;
    // wire[2:0] ByteCnt;
    // counter #(.width(3)) byteCounter(
    //     .clk(clk),
    //     .rst(rst),
    //     .init(ByteCInit),
    //     .cntEn(ByteCntEn),
    //     .cnt(ByteCnt)
    // );

    reg SCKInit;
    reg SCKCntEn;
    wire[1:0] SCKCnt;
    counter #(.width(2)) sckcounter(
        .clk(clk),
        .rst(rst),
        .init(SCKInit),
        .cntEn(SCKCntEn),
        .cnt(SCKCnt)
    );


    always @(posedge clk, posedge rst) begin
        if(rst) begin
            ps <= IDLE;
        end
        else begin
            ps <= ns;
        end
    end


    always @(ps, command, BitCnt, valid_in) begin
        case(ps)
            IDLE     : ns = (|command) ? WAIT : IDLE; 
			
            WAIT     : ns = ((command == 8'h00)) ? SEND_OP : WAIT;
							 
            SEND_OP  : ns = ((BitCnt == (1 * 8)) && (command_reg == READ_STATUS)) ? GET_DATA :
							 ((BitCnt == (1 * 8)) && (command_reg == WRITE_ENABLE)) ? IDLE :
							 ((BitCnt == (1 * 8)) && (command_reg == WRITE_STATUS)) ? SEND_DATA : 
							 ((BitCnt == (1 * 8)) && (command_reg == PAGE_PROGRAM)) ? SEND_ADDRESS :
							 ((BitCnt == (8 * 1)) && (command_reg == READ_DATA)) ? SEND_ADDRESS :
							 ((BitCnt == (8 * 1)) && (command_reg == SECTOR_ERASE)) ? SEND_ADDRESS : SEND_OP;
							 
            GET_DATA : ns = ((BitCnt == (8 * 1)) && (command_reg == READ_STATUS)) ? IDLE :
							 ((BitCnt == (8 * numByte_read_reg)) && (command_reg == READ_DATA)) ? IDLE : GET_DATA;
			
			SEND_DATA : ns = ((BitCnt == (8 * 1)) && (last_in_reg) && (command_reg == PAGE_PROGRAM)) ? IDLE : 
							  ((BitCnt == (8 * 1)) && (~last_in_reg) && (command_reg == PAGE_PROGRAM)) ? WAIT_FOR_DIN : 
							  ((BitCnt == (8 * 1)) &&  (command_reg == WRITE_STATUS)) ? IDLE : SEND_DATA;
			
			SEND_ADDRESS : ns = ((BitCnt == (8 * 3)) && (command_reg == PAGE_PROGRAM)) ? WAIT_FOR_DIN :
								 ((BitCnt == (8 * 3)) && (command_reg == READ_DATA)) ? GET_DATA :
								 ((BitCnt == (8 * 3)) && (command_reg == SECTOR_ERASE)) ? IDLE : SEND_ADDRESS;
			
			WAIT_FOR_DIN : ns = (valid_in) ? SEND_DATA : WAIT_FOR_DIN;
			
            default : ns = IDLE;
        endcase
    end

    always @(ps, SCKCnt, BitCnt, Sreg, valid_in) begin
        BitInit = 0;
        SCKInit = 0;
        BitCntEn = 0;
        SCKCntEn = 0;
        valid_reg = 0;
		shiftS = 0;
		loadS = 0;
		shiftD = 0;
		shiftAdr = 0;
		ready_in = 0;
		loadDI = 0;
        //SCK = 1;
        case(ps)
            IDLE    : begin
                CSbar = 1;
                SCK = 1;
            end

            WAIT    : begin
				loadS = 1;
                BitInit = 1;
                SCKInit = 1;
                CSbar = 0;
				SCK = 1;
            end

            SEND_OP : begin
                CSbar = 0;
                SCKCntEn = 1;
                if((SCKCnt == 0) || (SCKCnt == 1)) begin //&& (BitCnt != 0) for first fall edge
                    SCK = 1;
                end
                else if((SCKCnt == 2) || (SCKCnt == 3)) begin
                    SCK = 0;
                end

                if(SCKCnt == 3) begin
                    SCKInit = 1;
                    BitCntEn = 1;
                end
                if(SCKCnt == 1) begin //1
                    loadDI = 1; //DI = Sreg[7];
					shiftS = 1;
                end
				
				if(BitCnt == 8) begin
					BitInit = 1;
					loadS = 1;
				end
            end

            GET_DATA : begin
                CSbar = 0;
                SCKCntEn = 1;
                if((SCKCnt == 0) || (SCKCnt == 1)) begin
                    SCK = 1;
                end
                else if((SCKCnt == 2) || (SCKCnt == 3)) begin
                    SCK = 0;
                end

                if(SCKCnt == 3) begin
                    BitCntEn = 1;
                    SCKInit = 1;
					shiftD = 1;
                   // Dreg = {Dreg[6:0], DO}; 

                    if((BitCnt%8) == 7) begin
                        valid_reg = 1;
                    end 
                end
				
				
				
				/* if(BitCnt == 8) begin
					BitInit = 1;
				end */
				
            end
			
			SEND_DATA : begin
				CSbar = 0;
                SCKCntEn = 1;
                if((SCKCnt == 0) || (SCKCnt == 1)) begin //&& (BitCnt != 0) for first fall edge
                    SCK = 1;
                end
                else if((SCKCnt == 2) || (SCKCnt == 3)) begin
                    SCK = 0;
                end

                if(SCKCnt == 3) begin
                    SCKInit = 1;
                    BitCntEn = 1;
                end
                if(SCKCnt == 1) begin // 1
                    loadDI = 1; //DI = Sreg[7];
					shiftS = 1;
                end
				
				if(BitCnt == 8) begin
					BitInit = 1;
				end
			end
			
			SEND_ADDRESS : begin
				CSbar = 0;
                SCKCntEn = 1;
                if((SCKCnt == 0) || (SCKCnt == 1)) begin 
                    SCK = 1;
                end
                else if((SCKCnt == 2) || (SCKCnt == 3)) begin
                    SCK = 0;
                end

                if(SCKCnt == 3) begin
                    SCKInit = 1;
                    BitCntEn = 1;
                end
                if(SCKCnt == 1) begin //1
                    loadDI = 1;  //DI = address_reg[23];
					shiftAdr = 1;
                end
				
				if(BitCnt == (3*8)) begin
					BitInit = 1;
				end
			
			end
			
			WAIT_FOR_DIN : begin
				SCK = 1;
				ready_in = 1;
				
				if(valid_in) begin
					ready_in = 0;
					loadS = 1;
				end

			end


        endcase

    end





    always @(posedge clk) begin
        valid <= valid_reg;
    end
	
	
	always @(posedge clk) begin
		if(loadS)
			Sreg <= (ps == WAIT) ? command_reg : 
					(command_reg == WRITE_STATUS) ? data_in_reg :
					((command_reg == PAGE_PROGRAM) && (valid_in) && (ps == WAIT_FOR_DIN)) ? data_in : command_reg;
		else if(shiftS)
			Sreg <= (Sreg << 1);
		else
			Sreg <= Sreg;
	end
	
	always @(posedge clk) begin
		if(ps == IDLE)
			address_reg <= address;
		else if(shiftAdr)
			address_reg <= (address_reg << 1);
		else
			address_reg <= address_reg;
	end
	
	always @(posedge clk) begin
		if(shiftD)
			Dreg <= {Dreg[6:0], DO};
	end
	
	always @(posedge clk) begin
		if(valid_in)
			last_in_reg <= last_in;
	end
	
	always @(posedge clk) begin
		if(loadDI) 
			DI <= (ps == SEND_DATA) ? Sreg[7] : 
				  (ps == SEND_ADDRESS) ? address_reg[23] : Sreg[7];
		else
			DI <= DI;
	end

	
	always @(posedge clk) begin
		if(ps == IDLE) begin
			command_reg <= command;
			data_in_reg <= data_in;
			numByte_read_reg <= numByte_read;
			
		end
		else begin
			command_reg <= command_reg;
			data_in_reg <= data_in_reg;
			numByte_read_reg <= numByte_read_reg;
			
		end
	end
	
	assign data_out = Dreg;
	

//
//	ila_0 ila_0_inst(
//		.clk	(clk		),
//		.probe0	(rst),
//		.probe1	(command_reg),
//		.probe2	(DO			),
//		.probe3	(DI			),
//		.probe4	(SCK		),
//		.probe5	(CSbar		),
//		.probe6	(valid		),
//		.probe7 (Dreg),
//		.probe8 (Sreg),
//		.probe9 (ps),
//		.probe10 (SCKCnt),
//		.probe11 (valid_in),
//		.probe12 (last_in),
//		.probe13 (last_in_reg),
//		.probe14 (address_reg),
//		.probe15 (address)
//	); 
//  
//  
  
endmodule
