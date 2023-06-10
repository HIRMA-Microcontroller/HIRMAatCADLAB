library verilog;
use verilog.vl_types.all;
entity aftab_ICCD is
    generic(
        len             : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        inst            : in     vl_logic_vector;
        outPC           : in     vl_logic_vector;
        outADR          : in     vl_logic_vector;
        mipCC           : in     vl_logic_vector;
        mieCC           : in     vl_logic_vector;
        midelegCSR      : in     vl_logic_vector;
        medelegCSR      : in     vl_logic_vector;
        mieFieldCC      : in     vl_logic;
        uieFieldCC      : in     vl_logic;
        ldDelegation    : in     vl_logic;
        ldMachine       : in     vl_logic;
        ldUser          : in     vl_logic;
        tempFlags       : in     vl_logic_vector(5 downto 0);
        interruptRaise  : out    vl_logic;
        exceptionRaise  : out    vl_logic;
        delegationMode  : out    vl_logic_vector(1 downto 0);
        curPRV          : out    vl_logic_vector(1 downto 0);
        causeCode       : out    vl_logic_vector;
        trapValue       : out    vl_logic_vector
    );
end aftab_ICCD;
