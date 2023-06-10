library verilog;
use verilog.vl_types.all;
entity wrapper is
    generic(
        PAGE_DEPTH      : integer := 4096
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        read            : in     vl_logic;
        write           : in     vl_logic;
        ps              : out    vl_logic_vector(4 downto 0);
        ns              : out    vl_logic_vector(4 downto 0);
        numByte_read_wp : in     vl_logic_vector(7 downto 0);
        numByte_write   : in     vl_logic_vector(31 downto 0);
        address_wp      : in     vl_logic_vector(23 downto 0);
        CSbar           : in     vl_logic;
        valid_from_flash: in     vl_logic;
        command         : out    vl_logic_vector(7 downto 0);
        address         : out    vl_logic_vector(23 downto 0);
        valid_to_flash  : out    vl_logic;
        last_to_flash   : out    vl_logic;
        numByte_read    : out    vl_logic_vector(7 downto 0);
        ready_from_flash: in     vl_logic;
        flash_to_buf_data: out    vl_logic_vector(7 downto 0);
        buf_to_flash_data: in     vl_logic_vector(7 downto 0);
        flash_to_buf_data_wp: in     vl_logic_vector(7 downto 0);
        buf_to_flash_data_wp: out    vl_logic_vector(7 downto 0);
        wr_en_buf       : out    vl_logic;
        rd_en_buf       : out    vl_logic;
        buf_empty       : in     vl_logic;
        buf_full        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PAGE_DEPTH : constant is 1;
end wrapper;
