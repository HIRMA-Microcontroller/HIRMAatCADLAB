library verilog;
use verilog.vl_types.all;
entity aftab_TCL is
    generic(
        size            : integer := 33
    );
    port(
        \In\            : in     vl_logic_vector;
        \Out\           : out    vl_logic_vector;
        enable          : in     vl_logic
    );
end aftab_TCL;
