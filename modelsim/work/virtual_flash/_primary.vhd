library verilog;
use verilog.vl_types.all;
entity virtual_flash is
    generic(
        SECTOR_DEPTH    : integer := 2
    );
    port(
        SCK             : in     vl_logic;
        CSbar           : in     vl_logic;
        DI              : in     vl_logic;
        DO              : out    vl_logic
    );
end virtual_flash;
