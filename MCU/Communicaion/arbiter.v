/////////////////////////////////////////////
// A simple arbiter for internal bus       //
//     2 priority grants:                  //
//     GRANT0 has higher priority          //
//     GRANT1 has lower  priority          //
// Date: 01/08/2023                        //
/////////////////////////////////////////////
`timescale 1ns/1ns
module arbiter (
    input clk,
    input rst,
    input MASTER1_READ,
    input MASTER2_READ,
    input MASTER1_WRITE,
    input MASTER2_WRITE,
    output GRANT0,
    output GRANT1
);

    localparam [1:0] G0barG1bar = 2'b00;
    localparam [1:0] G0G1bar = 2'b01;
    localparam [1:0] G0barG1 = 2'b10;

    reg [1:0] ps, ns;

    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= G0barG1bar;
        else
            ps <= ns;
    end

    wire M1;
    wire M2;
    assign M1 = (MASTER1_READ | MASTER1_WRITE);
    assign M2 = (MASTER2_READ | MASTER2_WRITE);
    always @(ps, M1, M2, MASTER1_READ, MASTER2_READ, MASTER1_WRITE, MASTER2_WRITE) begin
        case (ps)
            G0barG1bar: ns <= ((~M1 && ~M2) ? G0barG1bar : ((M1) ? G0G1bar : ((M2 && ~M1) ? G0barG1 : G0barG1bar)));
            G0G1bar: ns <= (~M1) ? G0barG1bar : G0G1bar;
            G0barG1: ns <= ((M2 && ~M1) ? G0barG1 : ((M1) ? G0G1bar : ((~M1 && ~M2) ? G0barG1bar : G0barG1)));
            default: ns <= G0barG1bar;
        endcase
    end

    reg G0;
    reg G1;
    always @(ps, M1, M2, MASTER1_READ, MASTER2_READ, MASTER1_WRITE, MASTER2_WRITE) begin
        {G0, G1} = 2'b00;
        case (ps)
            G0barG1bar: {G0, G1} = 2'b00;
            G0G1bar: {G0, G1} = 2'b10;
            G0barG1: {G0, G1} = 2'b01;
            default: {G0, G1} = 2'b00;
        endcase
    end

    assign GRANT0 = G0;
    assign GRANT1 = G1;

endmodule