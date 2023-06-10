library verilog;
use verilog.vl_types.all;
entity aftab_adder is
    generic(
        size            : integer := 4
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        cin             : in     vl_logic;
        cout            : out    vl_logic;
        sum             : out    vl_logic_vector
    );
end aftab_adder;
