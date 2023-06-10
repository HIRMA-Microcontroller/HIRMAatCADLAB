library verilog;
use verilog.vl_types.all;
entity counter is
    generic(
        width           : integer := 2
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        init            : in     vl_logic;
        cntEn           : in     vl_logic;
        cnt             : out    vl_logic_vector
    );
end counter;
