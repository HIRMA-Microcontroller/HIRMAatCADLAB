remove_design -all
set designer "Amirmahdi"
set power_preserve_rtl_hier_names "true"
set search_path "/home/user1/MCU"
set my_files [list  ../MCU/aftab_project/baseModules/aftab_adder.v \
                    ../MCU/aftab_project/baseModules/aftab_counter.v \
                    ../MCU/aftab_project/baseModules/aftab_decoder2to4.v \
                    ../MCU/aftab_project/baseModules/aftab_mux2to1_2sel.v \
                    ../MCU/aftab_project/baseModules/aftab_mux2to1.v \
                    ../MCU/aftab_project/baseModules/aftab_mux4to1.v \
                    ../MCU/aftab_project/baseModules/aftab_opt_adder.v \
                    ../MCU/aftab_project/baseModules/aftab_register.v \
                    ../MCU/aftab_project/baseModules/aftab_shift_left_register.v \
                    ../MCU/aftab_project/baseModules/aftab_shift_right_register.v \
                    ../MCU/aftab_project/baseModules/aftab_TCL.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_multiplier.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_controller.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_booth_multiplier/aftab_booth_datapath.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_su_divider/aftab_divider.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_su_divider/aftab_divider_controller.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_su_divider/aftab_divider_datapath.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_su_divider/aftab_signed_divider.v \
                    ../MCU/aftab_project/datapath/aftab_aau/aftab_AAU.v \
                    ../MCU/aftab_project/datapath/aftab_daru/aftab_DARU_controller.v \
                    ../MCU/aftab_project/datapath/aftab_daru/aftab_DARU_datapath.v \
                    ../MCU/aftab_project/datapath/aftab_daru/aftab_DARU_errorDetector.v \
                    ../MCU/aftab_project/datapath/aftab_daru/aftab_MEM_DARU.v \
                    ../MCU/aftab_project/datapath/aftab_dawu/aftab_DAWU_controller.v \
                    ../MCU/aftab_project/datapath/aftab_dawu/aftab_DAWU_datapath.v \
                    ../MCU/aftab_project/datapath/aftab_dawu/aftab_DAWU_errorDetector.v \
                    ../MCU/aftab_project/datapath/aftab_dawu/aftab_MEM_DAWU.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_check_non_existing.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_CSR_address_ctrl.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_CSR_address_logic.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_CSR_addressing_decoder.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_CSR_counter.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_CSR_registers.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_CSRISL.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_ICCD.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_isagu.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_oneBitReg.v \
                    ../MCU/aftab_project/datapath/aftab_interrupt/aftab_register_bank.v \
                    ../MCU/aftab_project/datapath/aftab_adder_subtractor.v \
                    ../MCU/aftab_project/datapath/aftab_BSU.v \
                    ../MCU/aftab_project/datapath/aftab_comparator.v \
                    ../MCU/aftab_project/datapath/aftab_immSelSignExt.v \
                    ../MCU/aftab_project/datapath/aftab_LLU.v \
                    ../MCU/aftab_project/datapath/aftab_registerFile.v \
                    ../MCU/aftab_project/datapath/aftab_sulu.v \
                    ../MCU/aftab_project/aftab_controller.v \
                    ../MCU/aftab_project/aftab_core.v \
                    ../MCU/aftab_project/aftab_datapath.v \
                    ../MCU/Communicaion/arbiter.v \
                    ../MCU/Communicaion/externalBus.v \
                    ../MCU/Communicaion/internalBus.v \
                    ../MCU/SPI/BytesCounter.v \
                    ../MCU/SPI/counter.v \
                    ../MCU/SPI/fifo.v \
                    ../MCU/SPI/flash_cms.v \
                    ../MCU/SPI/FLASH_Controller.v \
                    ../MCU/SPI/SectorsController.v \
                    ../MCU/SPI/SPI_adress_Register.v \
                    ../MCU/SPI/SPIController.v \
                    ../MCU/SPI/SRAM_address_Register.v \
                    ../MCU/SPI/wrapper.v \
                    ../MCU/Timer/counterIO.v \
                    ../MCU/Timer/interleavedRegister.v \
                    ../MCU/Timer/registerIO.v \
                    ../MCU/Timer/timer.v \
                    ../MCU/UART/uart.v \
                    ../MCU/UART/UART_Conf.v \
                    ../MCU/UART/UART_interface.v \
                    ../MCU/UART/UART_reg.v \
                    ../MCU/UART/uart_rx.v \
                    ../MCU/UART/uart_tx.v \
                    ../MCU/MCU.v
    ]

define_design_lib work -path "work"

set virtual 0                                                 ;# 1 if virtual clock, 0 if real clock
set myPeriod_ns 25                                            ;# desire clock period (in ns) (sets speed goal)
set clk_name clk;
# set myClkLatency_ns 0                                         ;# clock network latency
# set myInDelay_ns 0                                            ;# delay from clock to inputs valid
# set myOutDelay_ns 0                                           ;# delay from clock to output valid

set topname "MCU"

set target_library  /tech3/GEN2/IP001316/arm/csm/ch018ull/sc7_base_rvt/r0p0/db/sc7_ch018ull_base_rvt_tt_typ_max_1p80v_25c.db
set link_library    /tech3/GEN2/IP001316/arm/csm/ch018ull/sc7_base_rvt/r0p0/db/sc7_ch018ull_base_rvt_tt_typ_max_1p80v_25c.db
set symbol_library  /tech3/GEN2/IP001316/arm/csm/ch018ull/sc7_base_rvt/r0p0/sdb/sc7_ch018ull_base_rvt.sdb

analyze -format verilog -lib work $my_files
#analyze -library WORK -format vhd $my_files

elaborate $topname -lib work -update
current_design $topname
link
uniquify

if { $virtual == 0 } {                                        ;# Setup clock
    create_clock -period $myPeriod_ns clk                     ;# Setup clock
} else {                                                      ;# Setup clock
    create_clock -period $myPeriod_ns -name clk               ;# Setup clock
}
set_drive 0 clk; #new


# set auto_wire_load_selection "true"
# set_max_delay 0.40 -from [ get_ports -filter {@port_direction == in}] -to [ get_ports -filter {@port_direction == out}]
#compile -ungroup_all
#compile_ultra
compile
redirect change_names {change_names -rules verilog -hierarchy -verbose }
#set sdfout_time_scale 0.001000

#rtl2saif -output "power/MCU.forward.saif" -design $topname
write -hierarchy -output "syn/MCU.ddc"
write -hier -format verilog -out "syn/MCU.v"
write_sdf -version 2.1 "syn/MCU.sdf"

report_timing -nworst 1  > "report/MCU.timing.report"
report_area  > "report/MCU.area.report"
report_constraint -all_violators > "report/MCU.constraint.report"
report_power > "report/MCU.power.report"
report_design > "report/MCU.design.report"
report_cell > "report/MCU.cell.report"
exit

#run modelsim:in a new terminal:> vsim
	#vsim –novopt ...
	#vcd file vcd_file.vcd
	#vcd add –r /tb_nvdla_matrix_multiplication_par_3/MATMUL/*
	#run -all (run -100ns)
	#quit -sim
	#vcd2saif -i vcd_file.vcd -o saif_file.saif

#read_saif -input saif_file.saif -instance tb_nvdla_matrix_multiplication_par_3/MATMUL
#report_power -cell -verbose > "report/MCU.power.report"
#exit
