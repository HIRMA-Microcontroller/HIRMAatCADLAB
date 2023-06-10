library verilog;
use verilog.vl_types.all;
entity aftab_comparator is
    generic(
        size            : integer := 32
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        comparedSignedUnsignedBar: in     vl_logic;
        lt              : out    vl_logic;
        eq              : out    vl_logic;
        gt              : out    vl_logic
    );
end aftab_comparator;
