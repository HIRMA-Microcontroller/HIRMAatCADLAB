library verilog;
use verilog.vl_types.all;
entity interface is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        AE              : in     vl_logic;
        EXT_AD          : in     vl_logic_vector(15 downto 0);
        memOut          : in     vl_logic_vector(7 downto 0);
        EXT_READY       : in     vl_logic;
        EXT_read        : in     vl_logic;
        EXT_write       : in     vl_logic;
        offChipAdd      : out    vl_logic_vector(13 downto 0);
        offChipData     : out    vl_logic_vector(7 downto 0);
        EXT_readOutput  : out    vl_logic;
        EXT_writeOutput : out    vl_logic;
        DT              : out    vl_logic_vector(7 downto 0)
    );
end interface;
