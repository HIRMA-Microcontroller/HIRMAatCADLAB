library verilog;
use verilog.vl_types.all;
entity aftab_CSRISL is
    generic(
        len             : integer := 32
    );
    port(
        selP1           : in     vl_logic;
        selIm           : in     vl_logic;
        selReadWrite    : in     vl_logic;
        clr             : in     vl_logic;
        set             : in     vl_logic;
        selPC           : in     vl_logic;
        selmip          : in     vl_logic;
        selCause        : in     vl_logic;
        selTval         : in     vl_logic;
        machineStatusAlterationPreCSR: in     vl_logic;
        userStatusAlterationPreCSR: in     vl_logic;
        machineStatusAlterationPostCSR: in     vl_logic;
        userStatusAlterationPostCSR: in     vl_logic;
        mirrorUstatus   : in     vl_logic;
        mirrorUie       : in     vl_logic;
        mirrorUip       : in     vl_logic;
        mirrorUser      : in     vl_logic;
        curPRV          : in     vl_logic_vector(1 downto 0);
        ir19_15         : in     vl_logic_vector(4 downto 0);
        CCmip           : in     vl_logic_vector;
        causeCode       : in     vl_logic_vector;
        trapValue       : in     vl_logic_vector;
        P1              : in     vl_logic_vector;
        PC              : in     vl_logic_vector;
        outCSR          : in     vl_logic_vector;
        previousPRV     : out    vl_logic_vector(1 downto 0);
        inCSR           : out    vl_logic_vector
    );
end aftab_CSRISL;
