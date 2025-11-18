`timescale 1ns / 1ps
//problem 5
module clk_divider(
    input clk,
    input reset,
    output reg slow_clk
);
    reg [25:0] counter;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            counter <= 26'd0;
            slow_clk <= 1'b0;
        end
        else
        begin
            if (counter == 26'd49_999_999)  // ≈ 1 Hz for 100 MHz clock
            begin
                slow_clk <= ~slow_clk;
                counter <= 26'd0;
            end
            else
                counter <= counter + 1;
        end
    end
endmodule
