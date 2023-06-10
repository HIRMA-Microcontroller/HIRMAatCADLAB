library verilog;
use verilog.vl_types.all;
entity aftab_adder_subtractor is
    generic(
        size            : integer := 32
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        subsel          : in     vl_logic;
        pass            : in     vl_logic;
        cout            : out    vl_logic;
        result          : out    vl_logic_vector
    );
end aftab_adder_subtractor;
