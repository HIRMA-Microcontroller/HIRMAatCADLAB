library verilog;
use verilog.vl_types.all;
entity aftab_opt_adder is
    generic(
        size            : integer := 4
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector(1 downto 0);
        sum             : out    vl_logic_vector
    );
end aftab_opt_adder;
