library verilog;
use verilog.vl_types.all;
entity aftab_MEM_DARU is
    generic(
        size            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        startDARU       : in     vl_logic;
        memReady        : in     vl_logic;
        dataInstrBar    : in     vl_logic;
        checkMisalignedDARU: in     vl_logic;
        addrIn          : in     vl_logic_vector;
        memData         : in     vl_logic_vector;
        nBytes          : in     vl_logic_vector(1 downto 0);
        completeDARU    : out    vl_logic;
        readMem         : out    vl_logic;
        instrMisalignedFlag: out    vl_logic;
        loadMisalignedFlag: out    vl_logic;
        dataOut         : out    vl_logic_vector;
        addrOut         : out    vl_logic_vector
    );
end aftab_MEM_DARU;
