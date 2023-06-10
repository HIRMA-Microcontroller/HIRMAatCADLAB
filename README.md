# Microcontroller
ICDC 2023 - Project
Lastest version of the main project and other required programs are kept here.
-----------------------------------------------------------------------------------------------------------
* SPI: 
      ------> SPI-Read: codes + vivado project
      ------> SPI-Write: codes + Vivado project
* MCU:
      ------> AFTAB-Project: risc-v codes (AFTAB multi-cycle processor with interrupt, verilog codes)
      ------> Communicaion: microcontroller internal and external bus + arbiter for internal bus
      ------> SPI: spi controller for writing microcontroller SRAM
      ------> Timer: 32-bit timer with overflow interrupt
      ------> UART: uart with 8-bit data, 1-bit stop bit, RX and TX interrupt, configurable baudrate
      ------> Virtual Flash: model of w25q in verilog
      ------> MCU: microcontroller top module
* modelsim:
      ------> MCU: .mpf + some test programs ( to test them, change .mem file in virtual_flash.v )
* quartus:
      ------> MCU: .qpf for cycloneIV-GX, DE2-i150 evaluation board
