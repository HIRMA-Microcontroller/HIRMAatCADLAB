library verilog;
use verilog.vl_types.all;
entity aftab_DAWU_controller is
    port(
        startDAWU       : in     vl_logic;
        memRdy          : in     vl_logic;
        coCnt           : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        iniCnt          : out    vl_logic;
        LdAddr          : out    vl_logic;
        LdNumBytes      : out    vl_logic;
        LdData          : out    vl_logic;
        enableData      : out    vl_logic;
        enableAddr      : out    vl_logic;
        writeMem        : out    vl_logic;
        incCnt          : out    vl_logic;
        completeDAWU    : out    vl_logic;
        zeroCnt         : out    vl_logic;
        zeroNumBytes    : out    vl_logic;
        zeroAddr        : out    vl_logic;
        zeroData        : out    vl_logic
    );
end aftab_DAWU_controller;
