`timescale 1ns / 1ps
//problem 1 testbench
module tb_moore_1100;

    reg clk, reset, x;
    wire z;

    // Instantiate the Unit Under Test (UUT)
    moore_1100 uut(
        .clk(clk),
        .reset(reset),
        .x(x),
        .z(z)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        reset = 1; x = 0;
        #10 reset = 0;

        // input pattern: 1100 1100
        #10 x = 1;
        #10 x = 1;
        #10 x = 0;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;
        #10 x = 0;
        #10 x = 0;

        #20 $finish;
    end

endmodule
