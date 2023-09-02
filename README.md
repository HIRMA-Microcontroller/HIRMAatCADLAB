# Microcontroller
CADLAB 2023 - Project
## Lastest version of the main project and other required programs are kept here.
-----------------------------------------------------------------------------------------------------------

* **SPI**:<br /> 
      &#8594; SPI-Read: codes + vivado project<br />
      &#8594; SPI-Write: codes + Vivado project<br />
* **MCU**:<br />
      &#8594; AFTAB-Project: risc-v codes (AFTAB multi-cycle processor with interrupt, verilog codes)<br />
      &#8594; Communicaion: microcontroller internal and external bus + arbiter for internal bus<br />
      &#8594; SPI: spi controller for writing microcontroller SRAM<br />
      &#8594; Timer: 32-bit timer with overflow interrupt<br />
      &#8594; UART: uart with 8-bit data, 1-bit stop bit, RX and TX interrupt, configurable baudrate<br />
      &#8594; Virtual Flash: model of w25q in verilog<br />
      &#8594; MCU: microcontroller top module<br />
* **modelsim**:<br />
      &#8594; MCU: .mpf + some test programs ( to test them, change .mem file in virtual_flash.v )<br />
* **quartus**:<br />
      &#8594; MCU: .qpf for cycloneIV-GX, DE2-i150 evaluation board<br />
* **Design_Compiler**:<br />
      &#8594; MCU: DC Script and synthesis results<br /><br /><br />
## The programmers View of the microcontroller:<br />

![image](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/1718be13-6501-4600-bd76-e74bc090ce00)


## MCU schematics in quartus:

![image](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/92484cff-2d67-4771-9801-15c61cd9ab21)



## Interrupt validation programs and results:
* Returning "Hello! I am AFTAB!" letter by letter after each interrupt:
![bandicam-2023-08-01-17-39-54-947](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/6da54b5c-5e96-4422-8ab7-51de142332ff)


* Returning the squared of the received value from UART with a 0x79 following that:
![bandicam-2023-08-01-17-21-25-353](https://github.com/AmirmahdiJoudi/Microcontroller/assets/79690242/8ba276bd-c579-4dfc-baac-527e7ec4c46e)













  

