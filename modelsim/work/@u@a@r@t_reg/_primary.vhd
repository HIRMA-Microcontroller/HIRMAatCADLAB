library verilog;
use verilog.vl_types.all;
entity UART_reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        load            : in     vl_logic;
        init            : in     vl_logic;
        pload           : in     vl_logic_vector(7 downto 0);
        pout            : out    vl_logic_vector(7 downto 0)
    );
end UART_reg;
