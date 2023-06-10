library verilog;
use verilog.vl_types.all;
entity aftab_mux2to1_2sel is
    generic(
        size            : integer := 32
    );
    port(
        i0              : in     vl_logic_vector;
        i1              : in     vl_logic_vector;
        s0              : in     vl_logic;
        s1              : in     vl_logic;
        w               : out    vl_logic_vector
    );
end aftab_mux2to1_2sel;
