library verilog;
use verilog.vl_types.all;
entity UART_interface is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        RX_bits         : in     vl_logic;
        BRl1            : in     vl_logic;
        BRl2            : in     vl_logic;
        BRl3            : in     vl_logic;
        BRl4            : in     vl_logic;
        BRInit          : in     vl_logic;
        ldTx            : in     vl_logic;
        pload           : in     vl_logic_vector(7 downto 0);
        loadMem         : in     vl_logic;
        initCnf         : in     vl_logic;
        CnfIn           : in     vl_logic_vector(7 downto 0);
        TX_bits         : out    vl_logic;
        CnfOut          : out    vl_logic_vector(7 downto 0);
        RXdata          : out    vl_logic_vector(7 downto 0);
        InterruptTX     : out    vl_logic;
        InterruptRX     : out    vl_logic
    );
end UART_interface;
