library verilog;
use verilog.vl_types.all;
entity uart_rx is
    generic(
        s_IDLE          : integer := 0;
        s_RX_START_BIT  : integer := 1;
        s_RX_DATA_BITS  : integer := 2;
        s_RX_STOP_BIT   : integer := 3;
        s_CLEANUP       : integer := 4
    );
    port(
        CLKS_PER_BIT    : in     vl_logic_vector(31 downto 0);
        ld_CLKS_PER_BIT : in     vl_logic;
        i_Clock         : in     vl_logic;
        rst             : in     vl_logic;
        i_Rx_Serial     : in     vl_logic;
        o_Rx_DV         : out    vl_logic;
        o_Rx_Byte       : out    vl_logic_vector(7 downto 0)
    );
end uart_rx;
