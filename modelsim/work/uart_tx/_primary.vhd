library verilog;
use verilog.vl_types.all;
entity uart_tx is
    generic(
        s_IDLE          : integer := 0;
        s_TX_START_BIT  : integer := 1;
        s_TX_DATA_BITS  : integer := 2;
        s_TX_STOP_BIT   : integer := 3;
        s_CLEANUP       : integer := 4
    );
    port(
        CLKS_PER_BIT    : in     vl_logic_vector(31 downto 0);
        ld_CLKS_PER_BIT : in     vl_logic;
        i_Clock         : in     vl_logic;
        rst             : in     vl_logic;
        i_Tx_DV         : in     vl_logic;
        i_Tx_Byte       : in     vl_logic_vector(7 downto 0);
        o_Tx_Active     : out    vl_logic;
        o_Tx_Serial     : out    vl_logic;
        o_Tx_Done       : out    vl_logic
    );
end uart_tx;
