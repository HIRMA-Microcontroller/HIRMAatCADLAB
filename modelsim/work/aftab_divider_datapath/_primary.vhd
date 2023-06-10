library verilog;
use verilog.vl_types.all;
entity aftab_divider_datapath is
    generic(
        size            : integer := 33
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Dividend        : in     vl_logic_vector;
        Divisor         : in     vl_logic_vector;
        ldRegR          : in     vl_logic;
        zeroRegR        : in     vl_logic;
        Q0              : in     vl_logic;
        seldividend     : in     vl_logic;
        selshQ          : in     vl_logic;
        ldRegQ          : in     vl_logic;
        zeroRegQ        : in     vl_logic;
        zeroRegM        : in     vl_logic;
        ldRegM          : in     vl_logic;
        shL_R           : in     vl_logic;
        shL_Q           : in     vl_logic;
        signR           : out    vl_logic;
        Q               : out    vl_logic_vector;
        Remainder       : out    vl_logic_vector
    );
end aftab_divider_datapath;
