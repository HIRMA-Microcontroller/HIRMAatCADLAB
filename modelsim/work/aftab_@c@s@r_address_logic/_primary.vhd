library verilog;
use verilog.vl_types.all;
entity aftab_CSR_address_logic is
    port(
        addressRegBank  : in     vl_logic_vector(11 downto 0);
        ldMieReg        : out    vl_logic;
        ldMieUieField   : out    vl_logic;
        mirrorUstatus   : out    vl_logic;
        mirrorUie       : out    vl_logic;
        mirrorUip       : out    vl_logic;
        mirror          : out    vl_logic
    );
end aftab_CSR_address_logic;
