library verilog;
use verilog.vl_types.all;
entity timer is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ilLoad1         : in     vl_logic;
        ilLoad2         : in     vl_logic;
        ilLoad3         : in     vl_logic;
        ilLoad4         : in     vl_logic;
        ilInit          : in     vl_logic;
        cvLoad1         : in     vl_logic;
        cvLoad2         : in     vl_logic;
        cvLoad3         : in     vl_logic;
        cvLoad4         : in     vl_logic;
        cvInit          : in     vl_logic;
        pload           : in     vl_logic_vector(7 downto 0);
        loadMem         : in     vl_logic;
        initCnf         : in     vl_logic;
        CnfIn           : in     vl_logic_vector(2 downto 0);
        CnfOut          : out    vl_logic_vector(7 downto 0);
        Interrupt       : out    vl_logic
    );
end timer;
