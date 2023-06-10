library verilog;
use verilog.vl_types.all;
entity aftab_isagu is
    generic(
        len             : integer := 32
    );
    port(
        tvecBase        : in     vl_logic_vector;
        causeCode       : in     vl_logic_vector(5 downto 0);
        modeTvec        : out    vl_logic_vector(1 downto 0);
        interruptStartAddressDirect: out    vl_logic_vector;
        interruptStartAddressVectored: out    vl_logic_vector
    );
end aftab_isagu;
