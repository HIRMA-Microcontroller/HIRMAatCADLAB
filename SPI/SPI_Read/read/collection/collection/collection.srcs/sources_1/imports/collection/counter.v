module counter # (
    parameter width = 2
    )
    (
    input clk,
    input rst,
    input init,
    input cntEn,
    output reg [width-1:0] cnt
    );

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            cnt <= 0;
        end
        else if (init)  begin
            cnt <= 0;
        end
        else if (cntEn) begin
            cnt <= cnt + 1'b1;
        end
        else begin
            cnt <= cnt;
        end
    end

endmodule
