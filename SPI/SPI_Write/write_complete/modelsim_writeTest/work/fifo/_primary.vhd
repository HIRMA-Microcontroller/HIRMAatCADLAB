library verilog;
use verilog.vl_types.all;
entity fifo is
    generic(
        BUF_SIZE        : integer := 53
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        buf_in          : in     vl_logic_vector(7 downto 0);
        buf_out         : out    vl_logic_vector(7 downto 0);
        wr_en           : in     vl_logic;
        rd_en           : in     vl_logic;
        buf_empty       : out    vl_logic;
        buf_full        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BUF_SIZE : constant is 1;
end fifo;
