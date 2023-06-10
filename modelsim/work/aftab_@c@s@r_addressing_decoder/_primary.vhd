library verilog;
use verilog.vl_types.all;
entity aftab_CSR_addressing_decoder is
    port(
        cntOutput       : in     vl_logic_vector(2 downto 0);
        outAddr         : out    vl_logic_vector(11 downto 0)
    );
end aftab_CSR_addressing_decoder;
