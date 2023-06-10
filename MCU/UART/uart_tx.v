`timescale 1ns/1ns
module uart_tx
(
    input [31:0] CLKS_PER_BIT,
    input       ld_CLKS_PER_BIT,
    input       i_Clock,
    input       rst,
    input       i_Tx_DV, // start by 1 value
    input [7:0] i_Tx_Byte, // must be set simultanously with start
    output      o_Tx_Active, // it is issued when transmit is happening
    output reg  o_Tx_Serial, // serial tx port
    output      o_Tx_Done // it is issued when a transmission is compeleted for one cycle.
);

  parameter s_IDLE         = 3'b000;
  parameter s_TX_START_BIT = 3'b001;
  parameter s_TX_DATA_BITS = 3'b010;
  parameter s_TX_STOP_BIT  = 3'b011;
  parameter s_CLEANUP      = 3'b100;

  reg [2:0]    r_SM_Main     ;
  reg [31:0]   r_Clock_Count ;
  reg [2:0]    r_Bit_Index   ;
  reg [7:0]    r_Tx_Data     ;
  reg          r_Tx_Done     ;
  reg          r_Tx_Active   ;
  reg [31:0]   CLKS_PER_BIT_s;

  always @(posedge i_Clock, posedge rst) begin
      if (rst)
        CLKS_PER_BIT_s <= 0;
      else if(ld_CLKS_PER_BIT)
        CLKS_PER_BIT_s <= CLKS_PER_BIT;
      else
        CLKS_PER_BIT_s <= CLKS_PER_BIT_s;
  end

  always @(posedge i_Clock, posedge rst)
    begin
      if(rst) begin
            r_SM_Main <= s_IDLE;
            o_Tx_Serial   <= 1'b1;
            r_Tx_Done     <= 1'b0;
            r_Tx_Active   <= 1'b0;
      end
      else begin
        case (r_SM_Main)
            s_IDLE :
            begin
                o_Tx_Serial   <= 1'b1;         // Drive Line High for Idle
                r_Tx_Done     <= 1'b0;
                r_Tx_Active   <= 1'b0;
                r_Clock_Count <= 0;
                r_Bit_Index   <= 0;

                if (i_Tx_DV == 1'b1)
                begin
                    r_Tx_Active <= 1'b1;
                    r_Tx_Data   <= i_Tx_Byte;
                    r_SM_Main   <= s_TX_START_BIT;
                end
                else
                r_SM_Main <= s_IDLE;
            end // case: s_IDLE


            // Send out Start Bit. Start bit = 0
            s_TX_START_BIT :
            begin
                o_Tx_Serial <= 1'b0;

                // Wait CLKS_PER_BIT_s-1 clock cycles for start bit to finish
                if (r_Clock_Count < CLKS_PER_BIT_s-1)
                begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_TX_START_BIT;
                end
                else
                begin
                    r_Clock_Count <= 0;
                    r_SM_Main     <= s_TX_DATA_BITS;
                end
            end // case: s_TX_START_BIT


            // Wait CLKS_PER_BIT_s-1 clock cycles for data bits to finish
            s_TX_DATA_BITS :
            begin
                o_Tx_Serial <= r_Tx_Data[r_Bit_Index];

                if (r_Clock_Count < CLKS_PER_BIT_s-1)
                begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_TX_DATA_BITS;
                end
                else
                begin
                    r_Clock_Count <= 0;

                    // Check if we have sent out all bits
                    if (r_Bit_Index < 7)
                    begin
                        r_Bit_Index <= r_Bit_Index + 1;
                        r_SM_Main   <= s_TX_DATA_BITS;
                    end
                    else
                    begin
                        r_Bit_Index <= 0;
                        r_SM_Main   <= s_TX_STOP_BIT;
                    end
                end
            end // case: s_TX_DATA_BITS


            // Send out Stop bit.  Stop bit = 1
            s_TX_STOP_BIT :
            begin
                o_Tx_Serial <= 1'b1;

                // Wait CLKS_PER_BIT_s-1 clock cycles for Stop bit to finish
                if (r_Clock_Count < CLKS_PER_BIT_s-1)
                begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_TX_STOP_BIT;
                end
                else
                begin
                    r_Tx_Done     <= 1'b1;
                    r_Clock_Count <= 0;
                    r_SM_Main     <= s_CLEANUP;
                    r_Tx_Active   <= 1'b0;
                end
            end // case: s_Tx_STOP_BIT


            // Stay here 1 clock
            s_CLEANUP :
            begin
                r_Tx_Done <= 1'b1;
                r_SM_Main <= s_IDLE;
            end


            default :
            r_SM_Main <= s_IDLE;

        endcase
      end
    end

  assign o_Tx_Active = r_Tx_Active;
  assign o_Tx_Done   = r_Tx_Done;

endmodule
