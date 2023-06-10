library verilog;
use verilog.vl_types.all;
entity SectorsController is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        initS           : in     vl_logic;
        ldS             : in     vl_logic;
        decS            : in     vl_logic;
        cntIn           : in     vl_logic_vector(7 downto 0);
        finished        : out    vl_logic;
        cnt             : out    vl_logic_vector(7 downto 0)
    );
end SectorsController;
