library verilog;
use verilog.vl_types.all;
entity auto_fifo_fill is
    generic(
        fifo_depth      : integer := 2000
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        direct_fifo     : out    vl_logic;
        direct_buf_in   : out    vl_logic_vector(7 downto 0);
        direct_wr_en_buf: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of fifo_depth : constant is 1;
end auto_fifo_fill;
