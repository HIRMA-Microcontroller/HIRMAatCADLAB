library verilog;
use verilog.vl_types.all;
entity aftab_BSU is
    generic(
        size            : integer := 32
    );
    port(
        dataIn          : in     vl_logic_vector;
        shiftAmount     : in     vl_logic_vector(4 downto 0);
        selShift        : in     vl_logic_vector(1 downto 0);
        dataOut         : out    vl_logic_vector
    );
end aftab_BSU;
