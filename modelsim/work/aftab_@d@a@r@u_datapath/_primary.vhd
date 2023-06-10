library verilog;
use verilog.vl_types.all;
entity aftab_DARU_datapath is
    generic(
        size            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        addrIn          : in     vl_logic_vector;
        nBytes          : in     vl_logic_vector(1 downto 0);
        ldAddr          : in     vl_logic;
        incCnt          : in     vl_logic;
        iniCnt          : in     vl_logic;
        selLdEn         : in     vl_logic;
        enableAddr      : in     vl_logic;
        enableData      : in     vl_logic;
        ldNumBytes      : in     vl_logic;
        initReading     : in     vl_logic;
        zeroAddr        : in     vl_logic;
        zeroNumBytes    : in     vl_logic;
        zeroCnt         : in     vl_logic;
        dataInstbar     : in     vl_logic;
        checkMisalignedDARU: in     vl_logic;
        initValueCnt    : in     vl_logic_vector(1 downto 0);
        memData         : in     vl_logic_vector;
        coCnt           : out    vl_logic;
        instrMisalignedFlag: out    vl_logic;
        loadMisalignedFlag: out    vl_logic;
        addrOut         : out    vl_logic_vector;
        dataOut         : out    vl_logic_vector
    );
end aftab_DARU_datapath;
