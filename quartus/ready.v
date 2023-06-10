module ready (
    input clk,
    input rst,
    input en,
    output external_Ready
);

    reg [13:0] cnt;
    always @(posedge clk, posedge rst) begin
        if (rst)
            cnt <= 14'd0;
        else if (external_Ready)
            cnt <= 14'd0;
        else if (en)
            cnt <= cnt + 14'd1;
    end

    assign external_Ready = (cnt==14'b10000000000000);
endmodule