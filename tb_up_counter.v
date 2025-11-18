`timescale 1ns / 1ps
//problem 3 tb
module tb_up_counter;

    reg clk, reset, enable;
    wire [11:0] count;

    // Instantiate UUT
    up_counter uut(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    // Clock generator: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize
        reset = 1; enable = 0;
        #10 reset = 0; enable = 1;

        // Let it count for a bit
        #200;

        // Trigger reset mid-count
        reset = 1; #10 reset = 0;

        // Continue counting
        #200;

        // Stop simulation
        $finish;
    end

endmodule
