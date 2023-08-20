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

![image](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/1718be13-6501-4600-bd76-e74bc090ce00)


MCU schematics in quartus:

![image](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/92484cff-2d67-4771-9801-15c61cd9ab21)



Interrupt validation programs and results:
* Returning "Hello! I am AFTAB!" letter by letter after each interrupt:
![bandicam-2023-08-01-17-39-54-947](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/6da54b5c-5e96-4422-8ab7-51de142332ff)


* Returning the squared of the received value from UART with a 0x79 following that:
![bandicam-2023-08-01-17-21-25-353](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/8ba276bd-c579-4dfc-baac-527e7ec4c46e)













  

