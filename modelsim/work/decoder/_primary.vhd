library verilog;
use verilog.vl_types.all;
entity decoder is
    generic(
        size            : integer := 32
    );
    port(
        shiftAmount     : in     vl_logic_vector(4 downto 0);
        outPut          : out    vl_logic_vector
    );
end decoder;
