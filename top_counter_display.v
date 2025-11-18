`timescale 1ns / 1ps
//problem 5
module top_counter_display(
    input clk,                // 100 MHz Basys 3 clock
    input reset,              // active-high reset
    output [6:0] seg,         // 7-segment cathode lines
    output [3:0] an           // display enables
);

    //============================
    // Internal connections
    //============================
    wire slow_clk;
    wire [11:0] count;
    wire [15:0] bcd_out;
    wire done;
    reg start;

    //============================
    // Slow clock for visible counting
    //============================
    clk_divider div_inst(
        .clk(clk),
        .reset(reset),
        .slow_clk(slow_clk)
    );

    //============================
    // 12-bit up counter
    //============================
    up_counter counter_inst(
        .clk(slow_clk),
        .reset(reset),
        .enable(1'b1),
        .count(count)
    );

    //============================
    // Binary → BCD converter
    //============================
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            start <= 1'b0;
        else
            start <= 1'b1;     // continuous conversion
    end

    bin2bcd converter_inst(
        .clk(clk),
        .reset(reset),
        .start(start),
        .bin_in(count),
        .bcd_out(bcd_out),
        .done(done)
    );

    //============================
    // 7-segment display driver
    // (Use the multi-digit driver from Lab 6)
    //============================
    multiseg_display display_inst(
        .clk(clk),
        .reset(reset),
        .bcd(bcd_out),
        .seg(seg),
        .an(an)
    );

endmodule
