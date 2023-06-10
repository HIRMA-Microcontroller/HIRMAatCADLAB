library verilog;
use verilog.vl_types.all;
entity aftab_decoder2to4 is
    port(
        dataIn          : in     vl_logic_vector(1 downto 0);
        En              : in     vl_logic;
        dataOut         : out    vl_logic_vector(3 downto 0)
    );
end aftab_decoder2to4;
