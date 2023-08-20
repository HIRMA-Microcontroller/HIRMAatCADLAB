# Microcontroller
CADLAB 2023 - Project

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
* Design_Compiler:
  
      ------> MCU: DC Script and synthesis results

The programmers View of the microcontroller:

  ![image](https://github.com/AmirmahdiJoudi/Microcontroller/assets/89470849/eb33c550-6d4c-419e-aa9d-bd16f4fa66fb)

MCU schematics in quartus:

  ![image](https://github.com/AmirmahdiJoudi/Microcontroller/assets/89470849/5ecd5e94-5d16-40ac-87f0-0aa59437bc8b)


Interrupt validation programs and results:
* Returning "Hello! I am AFTAB!" letter by letter after each interrupt:
  ![bandicam-2023-08-01-17-39-54-947](https://github.com/AmirmahdiJoudi/Microcontroller/assets/89470849/edb1556c-4b61-4e97-9a01-e149c6e921db)

* Returning the squared of the received value from UART with a 0x79 following that:
  ![bandicam-2023-08-01-17-21-25-353](https://github.com/AmirmahdiJoudi/Microcontroller/assets/89470849/1313c68e-8a04-4f37-86b8-7d0d78eb3ca1)













  

