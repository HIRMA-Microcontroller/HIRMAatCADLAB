library verilog;
use verilog.vl_types.all;
entity counterIO is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        initialLoad     : in     vl_logic_vector(31 downto 0);
        coValLoad       : in     vl_logic_vector(31 downto 0);
        init            : in     vl_logic;
        cntEn           : in     vl_logic;
        co              : out    vl_logic
    );
end counterIO;
