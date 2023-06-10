library verilog;
use verilog.vl_types.all;
entity aftab_LLU is
    generic(
        size            : integer := 32
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        selLogic        : in     vl_logic_vector(1 downto 0);
        lluResult       : out    vl_logic_vector
    );
end aftab_LLU;
