library verilog;
use verilog.vl_types.all;
entity aftab_booth_multiplier is
    generic(
        size            : integer := 33
    );
    port(
        M               : in     vl_logic_vector;
        Mr              : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        done            : out    vl_logic;
        P               : out    vl_logic_vector
    );
end aftab_booth_multiplier;
