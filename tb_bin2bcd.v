`timescale 1ns / 1ps

module tb_bin2bcd;

    reg clk, reset, start;
    reg [11:0] bin_in;
    wire [15:0] bcd_out;
    wire done;

    bin2bcd uut(
        .clk(clk),
        .reset(reset),
        .start(start),
        .bin_in(bin_in),
        .bcd_out(bcd_out),
        .done(done)
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        reset = 1; start = 0; bin_in = 12'd189;
        #10 reset = 0;
        #10 start = 1;      // begin conversion
        #10 start = 0;

        wait(done);         // wait for conversion to finish
        #20;

        $finish;
    end

endmodule
