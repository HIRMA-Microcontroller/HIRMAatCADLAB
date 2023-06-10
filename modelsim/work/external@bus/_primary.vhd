library verilog;
use verilog.vl_types.all;
entity externalBus is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        CPU_MEM_READ    : in     vl_logic;
        CPU_MEM_WRITE   : in     vl_logic;
        CPU_MEM_ADD     : in     vl_logic_vector(31 downto 0);
        CPU_MEM_DATA    : inout  vl_logic_vector(7 downto 0);
        CPY_MEM_READY   : out    vl_logic;
        EXT_MEM_READ    : out    vl_logic;
        EXT_MEM_WRITE   : out    vl_logic;
        AE              : out    vl_logic;
        EXT_AD          : inout  vl_logic_vector(15 downto 0);
        EXT_MEM_READY   : in     vl_logic;
        inDO            : out    vl_logic;
        inDI            : in     vl_logic;
        inSCK           : in     vl_logic;
        inCSbar         : in     vl_logic;
        exDO            : in     vl_logic;
        exDI            : out    vl_logic;
        exSCK           : out    vl_logic;
        exCSbar         : out    vl_logic
    );
end externalBus;
