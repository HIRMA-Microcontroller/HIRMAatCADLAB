library verilog;
use verilog.vl_types.all;
entity BytesCounter is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        initB           : in     vl_logic;
        incB            : in     vl_logic;
        align           : out    vl_logic;
        cnt             : out    vl_logic_vector(3 downto 0)
    );
end BytesCounter;
