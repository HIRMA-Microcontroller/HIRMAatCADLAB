`timescale 1ns/1ns

`define s_IDLE         3'b000
`define s_RX_START_BIT 3'b001
`define s_RX_DATA_BITS 3'b010
`define s_RX_STOP_BIT  3'b011
`define s_CLEANUP      3'b100

module uart_rx (
    input [31:0] CLKS_PER_BIT,
    input        ld_CLKS_PER_BIT,
    input        i_Clock,
    input        rst,
    input        i_Rx_Serial, // serial rx port
    output       o_Rx_DV, // it is issued when one receiving is compeleted for one cycle
    output [7:0] o_Rx_Byte
);

  reg           r_Rx_Data_R;
  reg           r_Rx_Data;

  reg [31:0]     r_Clock_Count;
  reg [2:0]     r_Bit_Index; //8 bits total
  reg [7:0]     r_Rx_Byte;
  reg           r_Rx_DV;
  reg [2:0]     ps, ns;

  reg [31:0]   CLKS_PER_BIT_s;

    always @(posedge i_Clock, posedge rst) begin
        if(rst)
            CLKS_PER_BIT_s <= 0;
        else if(ld_CLKS_PER_BIT)
            CLKS_PER_BIT_s <= CLKS_PER_BIT;
        else
            CLKS_PER_BIT_s <= CLKS_PER_BIT_s;
    end

  // Purpose: Double-register the incoming data.
  // This allows it to be used in the UART RX Clock Domain.
  // (It removes problems caused by metastability)
    always @(posedge i_Clock, posedge rst) begin
        if(rst) begin
            r_Rx_Data_R <= 0;
            r_Rx_Data   <= 0;
        end
        else begin
            r_Rx_Data_R <= i_Rx_Serial;
            r_Rx_Data   <= r_Rx_Data_R;
        end
    end

    reg initRcounter;
    reg incRcounter;
    always @(posedge i_Clock, posedge rst) begin
        if(rst) begin
                r_Clock_Count <= 0;
        end
        else if (initRcounter) begin
                r_Clock_Count <= 0;
        end
        else if (incRcounter) begin
                r_Clock_Count <= r_Clock_Count + 1'b1;
        end
        else
            r_Clock_Count <= r_Clock_Count;
    end

    reg initIcounter;
    reg incIcounter;
    always @(posedge i_Clock, posedge rst) begin
        if(rst) begin
			r_Bit_Index <= 0;
        end
        else if (initIcounter) begin
            r_Bit_Index <= 0;
        end
        else if (incIcounter) begin
            r_Bit_Index <= r_Bit_Index + 1'b1;
        end
        else
            r_Bit_Index <= r_Bit_Index;
    end
    reg initRxByte, ldRxByte;
    always @(posedge i_Clock, posedge rst) begin
        if(rst) begin
			r_Rx_Byte <= 0;
        end
        else if (initRxByte) begin
            r_Rx_Byte <= 0;
        end
        else if (ldRxByte) begin
            r_Rx_Byte <= {r_Rx_Data, r_Rx_Byte[7:1]};
        end
        else
            r_Rx_Byte <= r_Rx_Byte;
    end


    always @(posedge i_Clock, posedge rst) begin
        if(rst)
            ps <= `s_IDLE;
        else
            ps <= ns;
    end

  // Purpose: Control RX state machine
    always @(ps, r_Rx_Data, r_Clock_Count) begin
        ns            <= `s_IDLE;
        r_Rx_DV       <= 1'b0;
        initRcounter  <= 1'b0;
        incRcounter   <= 1'b0;
        initIcounter  <= 1'b0;
        incIcounter   <= 1'b0;
        initRxByte <= 0; ldRxByte <= 0;
        case (ps)
            `s_IDLE : begin
                initRxByte <= 1;
                initRcounter  <= 1'b1;
                incRcounter   <= 1'b0;
                if (r_Rx_Data == 1'b0)          // Start bit detected
                    ns <= `s_RX_START_BIT;
                else
                    ns <= `s_IDLE;
            end

            // Check middle of start bit to make sure it's still low
            `s_RX_START_BIT : begin
                if (r_Clock_Count == (CLKS_PER_BIT_s+2)/2) begin
                    if (r_Rx_Data == 1'b0) begin
                        initRcounter  <= 1'b1;  // reset counter, found the middle
                        ns            <= `s_RX_DATA_BITS;
                    end
                    else
                        ns <= `s_IDLE;
                end
                else begin
                    incRcounter   <= 1'b1;
                    ns            <= `s_RX_START_BIT;
                end
            end // case: `s_RX_START_BIT


            // Wait CLKS_PER_BIT_s-1 clock cycles to sample serial data
            `s_RX_DATA_BITS : begin
                if ((r_Clock_Count < CLKS_PER_BIT_s-1)) begin
                    incRcounter   <= 1'b1;
                    ns            <= `s_RX_DATA_BITS;
                end
                else begin
                    initRcounter  <= 1'b1;
                    ldRxByte <= 1'b1;
                        // Check if we have received all bits
                     if (r_Bit_Index < 7) begin
                        incIcounter   <= 1'b1;
                        ns            <= `s_RX_DATA_BITS;
                    end
                    else begin
                        initIcounter  <= 1'b1;
                        ns            <= `s_RX_STOP_BIT;
                    end
                end
            end // case: `s_RX_DATA_BITS


            // Receive Stop bit.  Stop bit = 1
            `s_RX_STOP_BIT : begin
                // Wait CLKS_PER_BIT_s-1 clock cycles for Stop bit to finish
                if ((r_Clock_Count < CLKS_PER_BIT_s-1)) begin
                        incRcounter   <= 1'b1;
                        ns            <= `s_RX_STOP_BIT;
                end
                else begin
                    r_Rx_DV       <= 1'b1;
                    initRcounter  <= 1'b1;
                    ns            <= `s_CLEANUP;
                end
            end // case: `s_RX_STOP_BIT


            // Stay here 1 clock
            `s_CLEANUP : begin
                ns        <= `s_IDLE;
                r_Rx_DV   <= 1'b0;
            end


            default :
                ns <= `s_IDLE;
        endcase

    end

    assign o_Rx_DV   = r_Rx_DV;
    assign o_Rx_Byte = r_Rx_Byte;

endmodule // uart_rx
