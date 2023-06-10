library verilog;
use verilog.vl_types.all;
entity aftab_memory_model is
    generic(
        dataWidth       : integer := 8;
        sector1Size     : integer := 4096;
        sector2Size     : integer := 4096;
        addressWidth    : integer := 32;
        cycle           : integer := 25;
        timer           : integer := 5
    );
    port(
        readmem         : in     vl_logic;
        writemem        : in     vl_logic;
        addressBus      : in     vl_logic_vector;
        dataBusIn       : in     vl_logic_vector;
        dataBusOut      : out    vl_logic_vector;
        memDataReady    : out    vl_logic
    );
end aftab_memory_model;
