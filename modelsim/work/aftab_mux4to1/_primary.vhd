library verilog;
use verilog.vl_types.all;
entity aftab_mux4to1 is
    generic(
        size            : integer := 32
    );
    port(
        i0              : in     vl_logic_vector;
        i1              : in     vl_logic_vector;
        i2              : in     vl_logic_vector;
        i3              : in     vl_logic_vector;
        sel             : in     vl_logic_vector(1 downto 0);
        dataOut         : out    vl_logic_vector
    );
end aftab_mux4to1;
