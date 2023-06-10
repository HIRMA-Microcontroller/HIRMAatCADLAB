library verilog;
use verilog.vl_types.all;
entity aftab_MEM_DAWU is
    generic(
        size            : integer := 32
    );
    port(
        addrIn          : in     vl_logic_vector;
        dataIn          : in     vl_logic_vector;
        nBytes          : in     vl_logic_vector(1 downto 0);
        startDAWU       : in     vl_logic;
        memReady        : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        checkMisalignedDAWU: in     vl_logic;
        addrOut         : out    vl_logic_vector;
        dataOut         : out    vl_logic_vector;
        storeMisalignedFlag: out    vl_logic;
        completeDAWU    : out    vl_logic;
        writeMem        : out    vl_logic
    );
end aftab_MEM_DAWU;
