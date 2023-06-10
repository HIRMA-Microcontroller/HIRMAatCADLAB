library verilog;
use verilog.vl_types.all;
entity aftab_memory_segment is
    generic(
        dataWidth       : integer := 8;
        addressWidth    : integer := 32;
        segmentID       : integer := 1;
        segmentSize     : integer := 2048;
        blockSize       : integer := 2048;
        startingAddress : integer := 0;
        cycle           : integer := 25;
        timer           : integer := 5;
        filenum         : integer := 1
    );
    port(
        readmem         : in     vl_logic;
        writemem        : in     vl_logic;
        addressBus      : in     vl_logic_vector;
        dataBusIn       : in     vl_logic_vector;
        dataBusOut      : out    vl_logic_vector;
        memDataReady    : out    vl_logic
    );
end aftab_memory_segment;
