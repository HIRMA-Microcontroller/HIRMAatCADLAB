library verilog;
use verilog.vl_types.all;
entity aftab_immSelSignExt is
    generic(
        size            : integer := 32
    );
    port(
        IR7             : in     vl_logic;
        IR20            : in     vl_logic;
        IR31            : in     vl_logic;
        IR11_8          : in     vl_logic_vector(3 downto 0);
        IR19_12         : in     vl_logic_vector(7 downto 0);
        IR24_21         : in     vl_logic_vector(3 downto 0);
        IR30_25         : in     vl_logic_vector(5 downto 0);
        selI            : in     vl_logic;
        selS            : in     vl_logic;
        selBUJ          : in     vl_logic;
        selIJ           : in     vl_logic;
        selSB           : in     vl_logic;
        selU            : in     vl_logic;
        selISBJ         : in     vl_logic;
        selIS           : in     vl_logic;
        selB            : in     vl_logic;
        selJ            : in     vl_logic;
        selISB          : in     vl_logic;
        selUJ           : in     vl_logic;
        Imm             : out    vl_logic_vector
    );
end aftab_immSelSignExt;
