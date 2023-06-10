library verilog;
use verilog.vl_types.all;
entity aftab_CSR_registers is
    generic(
        len             : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        writeRegBank    : in     vl_logic;
        addressRegBank  : in     vl_logic_vector(4 downto 0);
        inputRegBank    : in     vl_logic_vector;
        outRegBank      : out    vl_logic_vector;
        MSTATUS_INT_MODE: out    vl_logic
    );
end aftab_CSR_registers;
