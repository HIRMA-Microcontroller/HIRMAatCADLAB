library verilog;
use verilog.vl_types.all;
entity UART_Conf is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        loadMem         : in     vl_logic;
        loadTXactive    : in     vl_logic;
        loadTXdone      : in     vl_logic;
        loadRXdone      : in     vl_logic;
        init            : in     vl_logic;
        pload           : in     vl_logic_vector(7 downto 0);
        TXactive        : in     vl_logic;
        TXdone          : in     vl_logic;
        RXdone          : in     vl_logic;
        pout            : out    vl_logic_vector(7 downto 0)
    );
end UART_Conf;
