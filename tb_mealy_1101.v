`timescale 1ns / 1ps
//problem 2 tb
module tb_mealy_1101;

    reg clk, reset, x;
    wire z;

    mealy_1101 uut(
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

        // sequence: 1101, 1101 (should pulse z each time)
        #10 x = 1;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;   // -> detect
        #10 x = 1;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;   // -> detect

        #20 $finish;
    end

endmodule
