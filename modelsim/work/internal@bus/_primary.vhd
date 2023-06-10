library verilog;
use verilog.vl_types.all;
entity internalBus is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MASTER1_ADD     : in     vl_logic_vector(31 downto 0);
        MASTER2_ADD     : in     vl_logic_vector(31 downto 0);
        SLAVE_ADD       : out    vl_logic_vector(31 downto 0);
        MASTER1_DATA_IN : out    vl_logic_vector(7 downto 0);
        MASTER2_DATA_IN : out    vl_logic_vector(7 downto 0);
        SLAVE_DATA_IN   : out    vl_logic_vector(7 downto 0);
        MASTER1_DATA_OUT: in     vl_logic_vector(7 downto 0);
        MASTER2_DATA_OUT: in     vl_logic_vector(7 downto 0);
        SLAVE_DATA_OUT  : in     vl_logic_vector(7 downto 0);
        MASTER1_READ    : in     vl_logic;
        MASTER2_READ    : in     vl_logic;
        SLAVE_READ      : out    vl_logic;
        MASTER1_WRITE   : in     vl_logic;
        MASTER2_WRITE   : in     vl_logic;
        SPI_request     : in     vl_logic;
        SLAVE_WRITE     : out    vl_logic;
        MASTER1_READY   : out    vl_logic;
        MASTER2_READY   : out    vl_logic;
        SLAVE_READY     : in     vl_logic
    );
end internalBus;
