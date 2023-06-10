library verilog;
use verilog.vl_types.all;
entity aftab_booth_controller is
    generic(
        size            : integer := 4
    );
    port(
        startBooth      : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        op              : in     vl_logic_vector(1 downto 0);
        shrMr           : out    vl_logic;
        ldMr            : out    vl_logic;
        ldM             : out    vl_logic;
        ldP             : out    vl_logic;
        zeroP           : out    vl_logic;
        sel             : out    vl_logic;
        subsel          : out    vl_logic;
        done            : out    vl_logic
    );
end aftab_booth_controller;
