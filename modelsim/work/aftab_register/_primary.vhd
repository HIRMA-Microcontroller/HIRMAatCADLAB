library verilog;
use verilog.vl_types.all;
entity aftab_register is
    generic(
        size            : integer := 4
    );
    port(
        \in\            : in     vl_logic_vector;
        ldR             : in     vl_logic;
        clk             : in     vl_logic;
        zero            : in     vl_logic;
        rst             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
end aftab_register;
