#set_property -dict { PACKAGE_PIN W5     IOSTANDARD LVCMOS33 } [get_ports { clk }];
#set_property -dict { PACKAGE_PIN V17    IOSTANDARD LVCMOS33 } [get_ports { systemReset  }];
#set_property -dict { PACKAGE_PIN V16    IOSTANDARD LVCMOS33 } [get_ports { inputReset }];
#set_property -dict { PACKAGE_PIN W16     IOSTANDARD LVCMOS33 } [get_ports { DO }];
#set_property -dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { DI  }];
#set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33 } [get_ports { SCK }];
#set_property -dict { PACKAGE_PIN J2     IOSTANDARD LVCMOS33 } [get_ports { CSbar }];
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { valid  }];


set_property -dict { PACKAGE_PIN W5     IOSTANDARD LVCMOS33 } [get_ports { clk }];
set_property -dict { PACKAGE_PIN V17    IOSTANDARD LVCMOS33 } [get_ports { rst  }];
set_property -dict { PACKAGE_PIN J1     IOSTANDARD LVCMOS33 } [get_ports { DO }];
set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33 } [get_ports { DI  }];
set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { SCK }];
set_property -dict { PACKAGE_PIN G2     IOSTANDARD LVCMOS33 } [get_ports { CSbar }];

set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { VCC }];
set_property -dict { PACKAGE_PIN G2     IOSTANDARD LVCMOS33 } [get_ports { GND }];