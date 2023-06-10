library verilog;
use verilog.vl_types.all;
entity aftab_signed_divider is
    generic(
        size            : integer := 33
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        startSDiv       : in     vl_logic;
        SignedUnsignedbar: in     vl_logic;
        dividend        : in     vl_logic_vector;
        divisor         : in     vl_logic_vector;
        dividedByZeroFlag: out    vl_logic;
        doneSDiv        : out    vl_logic;
        Qout            : out    vl_logic_vector;
        Remout          : out    vl_logic_vector
    );
end aftab_signed_divider;
