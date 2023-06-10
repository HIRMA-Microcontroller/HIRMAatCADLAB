library verilog;
use verilog.vl_types.all;
entity aftab_divider is
    generic(
        size            : integer := 33
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        startDiv        : in     vl_logic;
        doneDiv         : out    vl_logic;
        dividend        : in     vl_logic_vector;
        divisor         : in     vl_logic_vector;
        Q               : out    vl_logic_vector;
        Remainder       : out    vl_logic_vector
    );
end aftab_divider;
