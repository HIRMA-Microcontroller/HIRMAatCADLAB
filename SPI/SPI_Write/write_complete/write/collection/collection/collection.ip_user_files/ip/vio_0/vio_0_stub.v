// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  4 12:09:22 2023
// Host        : DESKTOP-P49DHPK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/MCI/MicroController/SPI/write_complete/write/collection/collection/collection.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2019.1" *)
module vio_0(clk, probe_out0, probe_out1, probe_out2, 
  probe_out3, probe_out4, probe_out5)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[0:0],probe_out1[0:0],probe_out2[0:0],probe_out3[7:0],probe_out4[23:0],probe_out5[31:0]" */;
  input clk;
  output [0:0]probe_out0;
  output [0:0]probe_out1;
  output [0:0]probe_out2;
  output [7:0]probe_out3;
  output [23:0]probe_out4;
  output [31:0]probe_out5;
endmodule
