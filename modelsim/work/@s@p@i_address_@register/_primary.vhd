library verilog;
use verilog.vl_types.all;
entity SPI_address_Register is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        initP           : in     vl_logic;
        incP            : in     vl_logic;
        address         : out    vl_logic_vector(23 downto 0)
    );
end SPI_address_Register;
