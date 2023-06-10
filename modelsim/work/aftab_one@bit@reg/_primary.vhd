library verilog;
use verilog.vl_types.all;
entity aftab_oneBitReg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        zero            : in     vl_logic;
        load            : in     vl_logic;
        inReg           : in     vl_logic;
        outReg          : out    vl_logic
    );
end aftab_oneBitReg;
