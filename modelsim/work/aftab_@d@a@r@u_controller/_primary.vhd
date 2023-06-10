library verilog;
use verilog.vl_types.all;
entity aftab_DARU_controller is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        startDARU       : in     vl_logic;
        coCnt           : in     vl_logic;
        memReady        : in     vl_logic;
        iniCnt          : out    vl_logic;
        ldAddr          : out    vl_logic;
        zeroAddr        : out    vl_logic;
        zeroNumBytes    : out    vl_logic;
        initReading     : out    vl_logic;
        ldNumBytes      : out    vl_logic;
        selLdEn         : out    vl_logic;
        readMem         : out    vl_logic;
        enableAddr      : out    vl_logic;
        enableData      : out    vl_logic;
        incCnt          : out    vl_logic;
        zeroCnt         : out    vl_logic;
        completeDARU    : out    vl_logic
    );
end aftab_DARU_controller;
