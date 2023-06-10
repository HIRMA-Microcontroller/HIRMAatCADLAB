library verilog;
use verilog.vl_types.all;
entity flash_cms is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        command         : in     vl_logic_vector(7 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        address         : in     vl_logic_vector(23 downto 0);
        valid_in        : in     vl_logic;
        last_in         : in     vl_logic;
        numByte_read    : in     vl_logic_vector(7 downto 0);
        ready_in        : out    vl_logic;
        DO              : in     vl_logic;
        DI              : out    vl_logic;
        SCK             : out    vl_logic;
        CSbar           : out    vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0);
        valid           : out    vl_logic
    );
end flash_cms;
