library verilog;
use verilog.vl_types.all;
entity aftab_counter is
    generic(
        size            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        incCnt          : in     vl_logic;
        iniCnt          : in     vl_logic;
        zero            : in     vl_logic;
        initValue       : in     vl_logic_vector;
        dataOut         : out    vl_logic_vector;
        co              : out    vl_logic
    );
end aftab_counter;
