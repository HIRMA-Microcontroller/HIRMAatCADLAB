library verilog;
use verilog.vl_types.all;
entity uart is
    port(
        CLKS_PER_BIT    : in     vl_logic_vector(31 downto 0);
        ld_CLKS_PER_BIT : in     vl_logic;
        i_Clock         : in     vl_logic;
        rst             : in     vl_logic;
        i_Tx_DV         : in     vl_logic;
        i_Tx_Byte       : in     vl_logic_vector(7 downto 0);
        o_Tx_Active     : out    vl_logic;
        o_Tx_Serial     : out    vl_logic;
        o_Tx_Done       : out    vl_logic;
        i_Rx_Serial     : in     vl_logic;
        o_Rx_DV         : out    vl_logic;
        o_Rx_Byte       : out    vl_logic_vector(7 downto 0)
    );
end uart;
