`timescale 1ns / 1ps
//problem 3 
module up_counter(
    input clk,          // clock input
    input reset,        // asynchronous reset
    input enable,       // enable counting
    output reg [11:0] count  // 12-bit counter output
);

    // Sequential logic
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            count <= 12'd0;                       // reset counter to 0
        else if (enable)
        begin
            if (count == 12'd4095)
                count <= 12'd0;                   // wrap around
            else
                count <= count + 1;               // increment
        end
    end

endmodule
