library verilog;
use verilog.vl_types.all;
entity arbiter is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MASTER1_READ    : in     vl_logic;
        MASTER2_READ    : in     vl_logic;
        MASTER1_WRITE   : in     vl_logic;
        MASTER2_WRITE   : in     vl_logic;
        GRANT0          : out    vl_logic;
        GRANT1          : out    vl_logic
    );
end arbiter;
