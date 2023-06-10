library verilog;
use verilog.vl_types.all;
entity aftab_mux2to1 is
    generic(
        size            : integer := 33
    );
    port(
        i0              : in     vl_logic_vector;
        i1              : in     vl_logic_vector;
        sel             : in     vl_logic;
        result          : out    vl_logic_vector
    );
end aftab_mux2to1;
