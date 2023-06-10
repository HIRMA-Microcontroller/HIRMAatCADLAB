library verilog;
use verilog.vl_types.all;
entity top is
    generic(
        fifo_depth      : integer := 2000
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        DO              : in     vl_logic;
        DI              : out    vl_logic;
        SCK             : out    vl_logic;
        CSbar           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of fifo_depth : constant is 1;
end top;
