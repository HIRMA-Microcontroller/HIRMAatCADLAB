library verilog;
use verilog.vl_types.all;
entity collection is
    generic(
        fifo_depth      : integer := 2000
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        read            : in     vl_logic;
        write           : in     vl_logic;
        numByte_read_wp : in     vl_logic_vector(7 downto 0);
        numByte_write   : in     vl_logic_vector(31 downto 0);
        address_wp      : in     vl_logic_vector(23 downto 0);
        direct_fifo     : in     vl_logic;
        direct_buf_in   : in     vl_logic_vector(7 downto 0);
        direct_buf_out  : out    vl_logic_vector(7 downto 0);
        direct_wr_en_buf: in     vl_logic;
        direct_rd_en_buf: in     vl_logic;
        DO              : in     vl_logic;
        DI              : out    vl_logic;
        SCK             : out    vl_logic;
        CSbar           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of fifo_depth : constant is 1;
end collection;
