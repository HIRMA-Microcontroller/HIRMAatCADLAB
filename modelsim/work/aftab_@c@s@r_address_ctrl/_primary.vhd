library verilog;
use verilog.vl_types.all;
entity aftab_CSR_address_ctrl is
    port(
        addressRegBank  : in     vl_logic_vector(11 downto 0);
        validAddressCSR : out    vl_logic
    );
end aftab_CSR_address_ctrl;
