library verilog;
use verilog.vl_types.all;
entity MCU is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        UART_RX         : in     vl_logic;
        UART_TX         : out    vl_logic;
        CORE_machineExternalInterrupt: in     vl_logic;
        EXT_READ        : out    vl_logic;
        EXT_WRITE       : out    vl_logic;
        AE              : out    vl_logic;
        EXT_AD          : inout  vl_logic_vector(15 downto 0);
        EXT_READY       : in     vl_logic;
        SRAM_address    : out    vl_logic_vector(11 downto 0);
        SRAM_In         : out    vl_logic_vector(7 downto 0);
        SRAM_Read       : out    vl_logic;
        SRAM_Write      : out    vl_logic;
        SRAM_Out        : in     vl_logic_vector(7 downto 0);
        SPI_DO          : in     vl_logic;
        SPI_DI          : out    vl_logic;
        SPI_SCK         : out    vl_logic;
        SPI_CSbar       : out    vl_logic
    );
end MCU;
