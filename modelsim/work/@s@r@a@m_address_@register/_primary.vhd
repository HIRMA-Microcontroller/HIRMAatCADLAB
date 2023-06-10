library verilog;
use verilog.vl_types.all;
entity SRAM_address_Register is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        initR           : in     vl_logic;
        incR            : in     vl_logic;
        address         : out    vl_logic_vector(12 downto 0)
    );
end SRAM_address_Register;
