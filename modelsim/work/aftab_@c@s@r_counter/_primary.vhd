library verilog;
use verilog.vl_types.all;
entity aftab_CSR_counter is
    generic(
        len             : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dnCnt           : in     vl_logic;
        upCnt           : in     vl_logic;
        ldCnt           : in     vl_logic;
        zeroCnt         : in     vl_logic;
        ldValue         : in     vl_logic_vector;
        outCnt          : out    vl_logic_vector
    );
end aftab_CSR_counter;
