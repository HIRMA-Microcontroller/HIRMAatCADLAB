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

    reg [2:0]    ps, ns        ;
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

    always @(posedge i_Clock, posedge rst) begin
        if(rst)
            ps <= s_IDLE;
        else
            ps <= ns;
    end

    always @(ps, i_Tx_DV, r_Clock_Count) begin
        ns            <= s_IDLE;
        o_Tx_Serial   <= 1'b1;
        r_Tx_Done     <= 1'b0;
        r_Tx_Active   <= 1'b0;
        initRcounter  <= 1'b0;
        incRcounter   <= 1'b0;
        initIcounter  <= 1'b0;
        incIcounter   <= 1'b0;
        case (ps)
            s_IDLE : begin
                o_Tx_Serial   <= 1'b1;         // Drive Line High for Idle
                r_Tx_Done     <= 1'b0;
                r_Tx_Active   <= 1'b0;
                initRcounter  <= 1'b1;
                initIcounter  <= 1'b1;

                if (i_Tx_DV == 1'b1)
                begin
                    r_Tx_Active <= 1'b1;
                    r_Tx_Data   <= i_Tx_Byte;
                    ns          <= s_TX_START_BIT;
                end
                else
                    ns <= s_IDLE;
            end // case: s_IDLE

            // Send out Start Bit. Start bit = 0
            s_TX_START_BIT : begin
                o_Tx_Serial <= 1'b0;

                // Wait CLKS_PER_BIT_s-1 clock cycles for start bit to finish
                if ((r_Clock_Count < CLKS_PER_BIT_s-1))
                begin
                    incRcounter <= 1'b1;
                    ns          <= s_TX_START_BIT;
                end
                else
                begin
                    initRcounter <= 1'b1;
                    ns           <= s_TX_DATA_BITS;
                end
            end // case: s_TX_START_BIT


            // Wait CLKS_PER_BIT_s-1 clock cycles for data bits to finish
            s_TX_DATA_BITS : begin
                o_Tx_Serial <= r_Tx_Data[r_Bit_Index];

                if ((r_Clock_Count < CLKS_PER_BIT_s-1)) begin
                    incRcounter <= 1'b1;
                    ns          <= s_TX_DATA_BITS;
                end
                else begin
                    initRcounter <= 1'b1;

                    // Check if we have sent out all bits
                    if (r_Bit_Index < 7) begin
                        incIcounter <= 1'b1;
                        ns          <= s_TX_DATA_BITS;
                    end
                    else begin
                        initIcounter <= 1'b1;
                        ns           <= s_TX_STOP_BIT;
                    end
                end
            end // case: s_TX_DATA_BITS


            // Send out Stop bit.  Stop bit = 1
            s_TX_STOP_BIT : begin
                o_Tx_Serial <= 1'b1;

                // Wait CLKS_PER_BIT_s-1 clock cycles for Stop bit to finish
                if ((r_Clock_Count < CLKS_PER_BIT_s-1)) begin
                    incRcounter <= 1'b1;
                    ns          <= s_TX_STOP_BIT;
                end
                else begin
                    r_Tx_Done     <= 1'b1;
                    initRcounter  <= 1'b1;
                    ns            <= s_CLEANUP;
                    r_Tx_Active   <= 1'b0;
                end
            end // case: s_Tx_STOP_BIT


            // Stay here 1 clock
            s_CLEANUP : begin
                r_Tx_Done <= 1'b1;
                ns        <= s_IDLE;
            end


            default :
            ns <= s_IDLE;
        endcase

    end

  assign o_Tx_Active = r_Tx_Active;
  assign o_Tx_Done   = r_Tx_Done;

endmodule
