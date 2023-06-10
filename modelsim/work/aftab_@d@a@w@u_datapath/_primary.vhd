library verilog;
use verilog.vl_types.all;
entity aftab_DAWU_datapath is
    generic(
        size            : integer := 32
    );
    port(
        addrIn          : in     vl_logic_vector;
        dataIn          : in     vl_logic_vector;
        nBytes          : in     vl_logic_vector(1 downto 0);
        initValueCnt    : in     vl_logic_vector(1 downto 0);
        LdAddr          : in     vl_logic;
        LdNumBytes      : in     vl_logic;
        incCnt          : in     vl_logic;
        iniCnt          : in     vl_logic;
        LdData          : in     vl_logic;
        enableAddr      : in     vl_logic;
        enableData      : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        zeroCnt         : in     vl_logic;
        zeroNumBytes    : in     vl_logic;
        zeroAddr        : in     vl_logic;
        zeroData        : in     vl_logic;
        checkMisalignedDAWU: in     vl_logic;
        addrOut         : out    vl_logic_vector;
        dataOut         : out    vl_logic_vector;
        coCnt           : out    vl_logic;
        storeMisalignedFlag: out    vl_logic
    );
end aftab_DAWU_datapath;
