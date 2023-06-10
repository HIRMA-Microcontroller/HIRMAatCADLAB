library verilog;
use verilog.vl_types.all;
entity CNFregister is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        loadMem         : in     vl_logic;
        loadTmr         : in     vl_logic;
        init            : in     vl_logic;
        pload           : in     vl_logic_vector(7 downto 0);
        co              : in     vl_logic;
        pout            : out    vl_logic_vector(7 downto 0)
    );
end CNFregister;
