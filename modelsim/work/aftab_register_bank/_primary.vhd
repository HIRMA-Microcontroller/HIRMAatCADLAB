library verilog;
use verilog.vl_types.all;
entity aftab_register_bank is
    generic(
        len             : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        writeRegBank    : in     vl_logic;
        addressRegBank  : in     vl_logic_vector(11 downto 0);
        inputRegBank    : in     vl_logic_vector;
        loadMieReg      : in     vl_logic;
        loadMieUieField : in     vl_logic;
        outRegBank      : out    vl_logic_vector;
        mirrorUstatus   : out    vl_logic;
        mirrorUie       : out    vl_logic;
        mirrorUip       : out    vl_logic;
        mirror          : out    vl_logic;
        ldMieReg        : out    vl_logic;
        ldMieUieField   : out    vl_logic;
        outMieFieldCCreg: out    vl_logic;
        outUieFieldCCreg: out    vl_logic;
        outMieCCreg     : out    vl_logic_vector;
        MSTATUS_INT_MODE: out    vl_logic
    );
end aftab_register_bank;
