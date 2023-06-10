-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Mon Jun 05 00:19:36 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MCU_schematic IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		SPI_DO :  IN  STD_LOGIC;
		RX :  IN  STD_LOGIC;
		SPI_CSbar :  OUT  STD_LOGIC;
		SPI_CSK :  OUT  STD_LOGIC;
		SPI_DI :  OUT  STD_LOGIC;
		WRITE :  OUT  STD_LOGIC;
		READ :  OUT  STD_LOGIC;
		SPI_RESET :  OUT  STD_LOGIC;
		SPI_WP :  OUT  STD_LOGIC;
		AE :  OUT  STD_LOGIC;
		TX :  OUT  STD_LOGIC;
		AD :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		LEDs :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END MCU_schematic;

ARCHITECTURE bdf_type OF MCU_schematic IS 

COMPONENT ready
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 external_Ready : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mcu
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 UART_RX : IN STD_LOGIC;
		 CORE_machineExternalInterrupt : IN STD_LOGIC;
		 EXT_READY : IN STD_LOGIC;
		 SPI_DO : IN STD_LOGIC;
		 EXT_AD : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 SRAM_Out : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 UART_TX : OUT STD_LOGIC;
		 EXT_READ : OUT STD_LOGIC;
		 EXT_WRITE : OUT STD_LOGIC;
		 AE : OUT STD_LOGIC;
		 SRAM_Read : OUT STD_LOGIC;
		 SRAM_Write : OUT STD_LOGIC;
		 SPI_DI : OUT STD_LOGIC;
		 SPI_SCK : OUT STD_LOGIC;
		 SPI_CSbar : OUT STD_LOGIC;
		 SRAM_address : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 SRAM_In : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sram
	PORT(wren : IN STD_LOGIC;
		 rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT offchip
	PORT(wren : IN STD_LOGIC;
		 rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT interface
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 AE : IN STD_LOGIC;
		 EXT_READY : IN STD_LOGIC;
		 EXT_read : IN STD_LOGIC;
		 EXT_write : IN STD_LOGIC;
		 EXT_AD : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 memOut : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 EXT_readOutput : OUT STD_LOGIC;
		 EXT_writeOutput : OUT STD_LOGIC;
		 DT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 LEDs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 offChipAdd : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
		 offChipData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	EXT_AD :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;


BEGIN 
SPI_RESET <= '1';
SPI_WP <= '1';
WRITE <= SYNTHESIZED_WIRE_20;
READ <= SYNTHESIZED_WIRE_19;
AE <= SYNTHESIZED_WIRE_17;
AD <= SYNTHESIZED_WIRE_21;
SYNTHESIZED_WIRE_5 <= '0';



b2v_inst : ready
PORT MAP(clk => clk,
		 rst => SYNTHESIZED_WIRE_24,
		 en => SYNTHESIZED_WIRE_1,
		 external_Ready => SYNTHESIZED_WIRE_27);



SYNTHESIZED_WIRE_1 <= SYNTHESIZED_WIRE_25 OR SYNTHESIZED_WIRE_26;


b2v_inst13 : mcu
PORT MAP(clk => clk,
		 rst => SYNTHESIZED_WIRE_24,
		 UART_RX => RX,
		 CORE_machineExternalInterrupt => SYNTHESIZED_WIRE_5,
		 EXT_READY => SYNTHESIZED_WIRE_27,
		 SPI_DO => SPI_DO,
		 EXT_AD => SYNTHESIZED_WIRE_21,
		 SRAM_Out => SYNTHESIZED_WIRE_7,
		 UART_TX => TX,
		 EXT_READ => SYNTHESIZED_WIRE_19,
		 EXT_WRITE => SYNTHESIZED_WIRE_20,
		 AE => SYNTHESIZED_WIRE_17,
		 SRAM_Read => SYNTHESIZED_WIRE_9,
		 SRAM_Write => SYNTHESIZED_WIRE_8,
		 SPI_DI => SPI_DI,
		 SPI_SCK => SPI_CSK,
		 SPI_CSbar => SPI_CSbar,
		 SRAM_address => SYNTHESIZED_WIRE_10,
		 SRAM_In => SYNTHESIZED_WIRE_11);


b2v_inst2 : sram
PORT MAP(wren => SYNTHESIZED_WIRE_8,
		 rden => SYNTHESIZED_WIRE_9,
		 clock => clk,
		 address => SYNTHESIZED_WIRE_10,
		 data => SYNTHESIZED_WIRE_11,
		 q => SYNTHESIZED_WIRE_7);


SYNTHESIZED_WIRE_24 <= NOT(rst);




b2v_inst6 : offchip
PORT MAP(wren => SYNTHESIZED_WIRE_25,
		 rden => SYNTHESIZED_WIRE_26,
		 clock => clk,
		 address => SYNTHESIZED_WIRE_14,
		 data => SYNTHESIZED_WIRE_15,
		 q => SYNTHESIZED_WIRE_22);


b2v_inst8 : interface
PORT MAP(clk => clk,
		 rst => SYNTHESIZED_WIRE_24,
		 AE => SYNTHESIZED_WIRE_17,
		 EXT_READY => SYNTHESIZED_WIRE_27,
		 EXT_read => SYNTHESIZED_WIRE_19,
		 EXT_write => SYNTHESIZED_WIRE_20,
		 EXT_AD => SYNTHESIZED_WIRE_21,
		 memOut => SYNTHESIZED_WIRE_22,
		 EXT_readOutput => SYNTHESIZED_WIRE_26,
		 EXT_writeOutput => SYNTHESIZED_WIRE_25,
		 LEDs => LEDs,
		 offChipAdd => SYNTHESIZED_WIRE_14,
		 offChipData => SYNTHESIZED_WIRE_15);


END bdf_type;