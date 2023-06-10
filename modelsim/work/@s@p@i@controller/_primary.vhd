library verilog;
use verilog.vl_types.all;
entity SPIController is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        memReady        : in     vl_logic;
        Empty           : in     vl_logic;
        FIFO_data       : in     vl_logic_vector(7 downto 0);
        ReadFIFO        : out    vl_logic;
        Flash_Read      : out    vl_logic;
        memRead         : out    vl_logic;
        memWrite        : out    vl_logic;
        done            : out    vl_logic;
        memdataOut      : out    vl_logic_vector(7 downto 0);
        memAddress      : out    vl_logic_vector(31 downto 0);
        Flah_Start      : out    vl_logic_vector(23 downto 0)
    );
end SPIController;
