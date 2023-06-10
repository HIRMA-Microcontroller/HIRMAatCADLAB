library verilog;
use verilog.vl_types.all;
entity aftab_booth_datapath is
    generic(
        size            : integer := 33
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        shrMr           : in     vl_logic;
        ldMr            : in     vl_logic;
        ldM             : in     vl_logic;
        ldP             : in     vl_logic;
        zeroP           : in     vl_logic;
        sel             : in     vl_logic;
        subsel          : in     vl_logic;
        M               : in     vl_logic_vector;
        Mr              : in     vl_logic_vector;
        P               : out    vl_logic_vector;
        op              : out    vl_logic_vector(1 downto 0)
    );
end aftab_booth_datapath;
