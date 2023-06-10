library verilog;
use verilog.vl_types.all;
entity aftab_divider_controller is
    generic(
        size            : integer := 33
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        startDiv        : in     vl_logic;
        signR           : in     vl_logic;
        doneDiv         : out    vl_logic;
        ldRegR          : out    vl_logic;
        zeroRegR        : out    vl_logic;
        seldividend     : out    vl_logic;
        selshQ          : out    vl_logic;
        ldRegQ          : out    vl_logic;
        zeroRegQ        : out    vl_logic;
        ldRegM          : out    vl_logic;
        zeroRegM        : out    vl_logic;
        shL_R           : out    vl_logic;
        shL_Q           : out    vl_logic;
        Q0              : out    vl_logic
    );
end aftab_divider_controller;
