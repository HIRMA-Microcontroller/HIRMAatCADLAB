library verilog;
use verilog.vl_types.all;
entity interleavedRegister is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        load1           : in     vl_logic;
        load2           : in     vl_logic;
        load3           : in     vl_logic;
        load4           : in     vl_logic;
        init            : in     vl_logic;
        pload           : in     vl_logic_vector(7 downto 0);
        pout            : out    vl_logic_vector(31 downto 0)
    );
end interleavedRegister;
