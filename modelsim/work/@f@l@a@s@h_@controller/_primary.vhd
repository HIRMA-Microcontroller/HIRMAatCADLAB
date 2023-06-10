library verilog;
use verilog.vl_types.all;
entity FLASH_Controller is
    generic(
        CHUNK_DEPTH     : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        read            : in     vl_logic;
        read_chunk      : in     vl_logic;
        write           : in     vl_logic;
        numByte_read_wp : in     vl_logic_vector(7 downto 0);
        address_wp      : in     vl_logic_vector(23 downto 0);
        buf_out         : out    vl_logic_vector(7 downto 0);
        rden            : in     vl_logic;
        buf_empty       : out    vl_logic;
        buf_full        : out    vl_logic;
        DO              : in     vl_logic;
        DI              : out    vl_logic;
        SCK             : out    vl_logic;
        CSbar           : out    vl_logic
    );
end FLASH_Controller;
