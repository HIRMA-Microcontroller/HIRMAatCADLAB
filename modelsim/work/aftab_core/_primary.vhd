library verilog;
use verilog.vl_types.all;
entity aftab_core is
    generic(
        size            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        memReady        : in     vl_logic;
        memDataIn       : in     vl_logic_vector(7 downto 0);
        memDataOut      : out    vl_logic_vector(7 downto 0);
        memRead         : out    vl_logic;
        memWrite        : out    vl_logic;
        memAddr         : out    vl_logic_vector;
        machineExternalInterrupt: in     vl_logic;
        machineTimerInterrupt: in     vl_logic;
        machineSoftwareInterrupt: in     vl_logic;
        userExternalInterrupt: in     vl_logic;
        userTimerInterrupt: in     vl_logic;
        userSoftwareInterrupt: in     vl_logic;
        platformInterruptSignals: in     vl_logic_vector(15 downto 0);
        interruptProcessing: out    vl_logic
    );
end aftab_core;
