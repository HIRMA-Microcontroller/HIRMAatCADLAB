library verilog;
use verilog.vl_types.all;
entity aftab_sulu is
    generic(
        size            : integer := 32
    );
    port(
        loadByteSigned  : in     vl_logic;
        loadHalfSigned  : in     vl_logic;
        load            : in     vl_logic;
        dataIn          : in     vl_logic_vector;
        dataOut         : out    vl_logic_vector
    );
end aftab_sulu;
