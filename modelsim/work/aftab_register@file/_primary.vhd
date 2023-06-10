library verilog;
use verilog.vl_types.all;
entity aftab_registerFile is
    generic(
        size            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        setZero         : in     vl_logic;
        setOne          : in     vl_logic;
        rs1             : in     vl_logic_vector(4 downto 0);
        rs2             : in     vl_logic_vector(4 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        writeData       : in     vl_logic_vector;
        writeRegFile    : in     vl_logic;
        p1              : out    vl_logic_vector;
        p2              : out    vl_logic_vector
    );
end aftab_registerFile;
