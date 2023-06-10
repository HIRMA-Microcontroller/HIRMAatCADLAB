library verilog;
use verilog.vl_types.all;
entity wrapper is
    generic(
        CHUNK_DEPTH     : integer := 4
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        read            : in     vl_logic;
        read_chunk      : in     vl_logic;
        write           : in     vl_logic;
        full_numByte    : out    vl_logic_vector(7 downto 0);
        cnt_RB          : out    vl_logic_vector(7 downto 0);
        ps              : out    vl_logic_vector(5 downto 0);
        ns              : out    vl_logic_vector(5 downto 0);
        numByte_read_wp : in     vl_logic_vector(7 downto 0);
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
end wrapper;
