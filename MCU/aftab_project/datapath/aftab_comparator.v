// **************************************************************************************
// Filename: aftab_comparator.v
// Project: AFTAB
// Version: 1.0
// Date:
//
// Module Name: aftab_comparator
// Description:
//
// Dependencies:
//
// File content description:
// comparator for AFTAB datapath
//
// **************************************************************************************
`timescale 1ns/1ns

module aftab_comparator #(parameter size = 32) (
    input [size-1:0] a,
    input [size-1:0] b,
    input comparedSignedUnsignedBar,
    output lt,
    output eq,
    output gt
);

    wire [size-1:0] sub;

    assign sub = (a-b);
    assign lt = (comparedSignedUnsignedBar == 1'b1 && a != b) ? sub[size-1] : a < b;
    assign eq = (a == b) ;
    assign gt = (comparedSignedUnsignedBar == 1'b1 && a != b) ? ~sub[size-1] : a > b;

endmodule