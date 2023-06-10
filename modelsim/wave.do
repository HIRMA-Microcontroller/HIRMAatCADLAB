onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB
add wave -noupdate -group TB -format Logic /MCU_TB/clk
add wave -noupdate -group TB -format Logic /MCU_TB/rst
add wave -noupdate -group TB -format Logic /MCU_TB/AE
add wave -noupdate -group TB -format Logic /MCU_TB/DI
add wave -noupdate -group TB -format Logic /MCU_TB/DO
add wave -noupdate -group TB -format Logic /MCU_TB/SCK
add wave -noupdate -group TB -format Logic /MCU_TB/CSbar
add wave -noupdate -group TB -format Literal -radix hexadecimal /MCU_TB/DT
add wave -noupdate -group TB -format Logic /MCU_TB/CORE_machineExternalInterrupt
add wave -noupdate -group TB -format Literal -radix unsigned /MCU_TB/EXT_AD
add wave -noupdate -group TB -format Logic /MCU_TB/EXT_READ
add wave -noupdate -group TB -format Logic /MCU_TB/EXT_READY
add wave -noupdate -group TB -format Logic /MCU_TB/EXT_WRITE
add wave -noupdate -group TB -format Literal -radix unsigned /MCU_TB/MEM_memAddr
add wave -noupdate -group TB -format Logic /MCU_TB/MEM_memRead
add wave -noupdate -group TB -format Logic /MCU_TB/MEM_memWrite
add wave -noupdate -group TB -format Literal /MCU_TB/MEM_memDataIN
add wave -noupdate -group TB -format Literal -radix hexadecimal /MCU_TB/MEM_memDataOut
add wave -noupdate -group MCU
add wave -noupdate -group MCU -format Logic /MCU_TB/MICRO_CONTROLLER/INTERNAL_BUS/ARBITER/GRANT0
add wave -noupdate -group MCU -format Logic /MCU_TB/MICRO_CONTROLLER/INTERNAL_BUS/ARBITER/GRANT1
add wave -noupdate -group MCU -format Literal -radix hexadecimal /MCU_TB/MICRO_CONTROLLER/CORE/datapath/regPC/out
add wave -noupdate -group MCU -format Literal -radix hexadecimal /MCU_TB/MICRO_CONTROLLER/CORE/datapath/registerFile/register_file
add wave -noupdate -group MCU -format Logic /MCU_TB/MICRO_CONTROLLER/IOEn
add wave -noupdate -group MCU -format Literal /MCU_TB/MICRO_CONTROLLER/IOVal
add wave -noupdate -group MCU -format Logic /MCU_TB/MICRO_CONTROLLER/offChipEn
add wave -noupdate -group MCU -format Literal /MCU_TB/MICRO_CONTROLLER/offChipVal
add wave -noupdate -group MCU -format Literal /MCU_TB/MICRO_CONTROLLER/onChipVal
add wave -noupdate -group MCU -format Literal -radix hexadecimal /MCU_TB/MICRO_CONTROLLER/cnt
add wave -noupdate -group MCU -format Literal -radix hexadecimal /MCU_TB/MICRO_CONTROLLER/readyReg
add wave -noupdate -group MCU -format Logic /MCU_TB/MICRO_CONTROLLER/MEM_memRead
add wave -noupdate -group MCU -format Logic /MCU_TB/MICRO_CONTROLLER/MEM_memWrite
add wave -noupdate -group MCU -format Literal /MCU_TB/MICRO_CONTROLLER/MEM_memDataIN
add wave -noupdate -group MCU -format Literal /MCU_TB/MICRO_CONTROLLER/MEM_memDataOUT
add wave -noupdate -group MCU -format Literal /MCU_TB/MICRO_CONTROLLER/CORE_memData_IN
add wave -noupdate -group MCU -format Literal -radix hexadecimal /MCU_TB/MICRO_CONTROLLER/MEM_memAddr
add wave -noupdate -group SRAM
add wave -noupdate -group SRAM -format Literal -radix unsigned /MCU_TB/MEMORY/seg1/mem
add wave -noupdate -group SRAM -format Logic /MCU_TB/MEMORY/seg1/readmem
add wave -noupdate -group SRAM -format Logic /MCU_TB/MEMORY/seg1/writemem
add wave -noupdate -group offChip
add wave -noupdate -group offChip -format Literal -radix unsigned /MCU_TB/offChip/addressBus
add wave -noupdate -group offChip -format Literal /MCU_TB/offChip/dataBusIn
add wave -noupdate -group offChip -format Literal /MCU_TB/offChip/dataBusOut
add wave -noupdate -group offChip -format Logic /MCU_TB/offChip/readmem
add wave -noupdate -group offChip -format Logic /MCU_TB/offChip/writemem
add wave -noupdate -group offChip -format Logic /MCU_TB/offChip/memDataReady
add wave -noupdate -group offChip -format Logic /MCU_TB/offChip/seg1/cs
add wave -noupdate -group offChip -format Literal /MCU_TB/offChip/seg1/mem
add wave -noupdate -group TMR
add wave -noupdate -group TMR -format Literal /MCU_TB/MICRO_CONTROLLER/TMR/CnfOut
add wave -noupdate -group TMR -format Literal /MCU_TB/MICRO_CONTROLLER/TMR/cvOut
add wave -noupdate -group TMR -format Literal /MCU_TB/MICRO_CONTROLLER/TMR/ilOut
add wave -noupdate -group TMR -format Logic /MCU_TB/MICRO_CONTROLLER/TMR/initCnf
add wave -noupdate -group TMR -format Logic /MCU_TB/MICRO_CONTROLLER/TMR/initTimer
add wave -noupdate -group TMR -format Logic /MCU_TB/MICRO_CONTROLLER/TMR/Interrupt
add wave -noupdate -group TMR -format Logic /MCU_TB/MICRO_CONTROLLER/TMR/loadMem
add wave -noupdate -group TMR -format Logic /MCU_TB/MICRO_CONTROLLER/TMR/startTimer
add wave -noupdate -group UART
add wave -noupdate -group UART -format Literal /MCU_TB/MICRO_CONTROLLER/URT/BRout
add wave -noupdate -group UART -format Literal /MCU_TB/MICRO_CONTROLLER/URT/CnfOut
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/initCNF
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/InterruptRX
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/InterruptTX
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/LD_BR
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/ldTx
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/loadMem
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/RX_bits
add wave -noupdate -group UART -format Literal /MCU_TB/MICRO_CONTROLLER/URT/RX_Byte
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/RX_INT_EN
add wave -noupdate -group UART -format Literal /MCU_TB/MICRO_CONTROLLER/URT/RXdata
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/TX_active
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/TX_bits
add wave -noupdate -group UART -format Literal /MCU_TB/MICRO_CONTROLLER/URT/TX_Byte
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/TX_Done
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/TX_INT_EN
add wave -noupdate -group UART -format Logic /MCU_TB/MICRO_CONTROLLER/URT/TX_start
add wave -noupdate -group Flash
add wave -noupdate -group Flash -format Logic /MCU_TB/FLASH/DI
add wave -noupdate -group Flash -format Logic /MCU_TB/FLASH/DO
add wave -noupdate -group Flash -format Literal /MCU_TB/FLASH/mem
add wave -noupdate -group Flash -format Logic /MCU_TB/FLASH/SCK
add wave -noupdate -expand -group {CU States}
add wave -noupdate -group {CU States} -format Literal /MCU_TB/MICRO_CONTROLLER/CORE/CU/p_state
add wave -noupdate -group {CU States} -format Literal /MCU_TB/MICRO_CONTROLLER/CORE/CU/n_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45623180000 ps} 0}
configure wave -namecolwidth 531
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {44794543192 ps} {45862015064 ps}
