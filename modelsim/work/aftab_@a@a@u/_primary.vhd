library verilog;
use verilog.vl_types.all;
entity aftab_AAU is
    generic(
        size            : integer := 32
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        multAAU         : in     vl_logic;
        divideAAU       : in     vl_logic;
        signedSigned    : in     vl_logic;
        signedUnsigned  : in     vl_logic;
        unsignedUnsigned: in     vl_logic;
        H               : out    vl_logic_vector;
        L               : out    vl_logic_vector;
        completeAAU     : out    vl_logic;
        dividedByZeroFlag: out    vl_logic
    );
end aftab_AAU;
