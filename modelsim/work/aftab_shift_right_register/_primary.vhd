library verilog;
use verilog.vl_types.all;
entity aftab_shift_right_register is
    generic(
        size            : integer := 32
    );
    port(
        dataIn          : in     vl_logic_vector;
        sh_R_en         : in     vl_logic;
        init            : in     vl_logic;
        serIn           : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Ld              : in     vl_logic;
        dataOut         : out    vl_logic_vector;
        serOut          : out    vl_logic
    );
end aftab_shift_right_register;
