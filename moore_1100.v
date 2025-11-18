`timescale 1ns / 1ps
//problem 1
module moore_1100(
    input clk,
    input reset,
    input x,          // serial input
    output reg z      // output high when 1100 detected
);

    // Define states
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    reg [2:0] PS, NS;

    // State Register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            PS <= S0;
        else
            PS <= NS;
    end

    // Next State Logic
    always @(PS or x)
    begin
        case (PS)
            S0: begin
                if (x)
                    NS = S1;     // got '1'
                else
                    NS = S0;
            end

            S1: begin
                if (x)
                    NS = S2;     // got '11'
                else
                    NS = S0;
            end

            S2: begin
                if (x)
                    NS = S2;     // stay if more 1's
                else
                    NS = S3;     // got '110'
            end

            S3: begin
                if (x)
                    NS = S4;     // got '1100'
                else
                    NS = S0;
            end

            S4: begin
                if (x)
                    NS = S2;     // overlapping case: 1100(1...) → '11'
                else
                    NS = S0;
            end

            default: NS = S0;
        endcase
    end

    // Output Logic (Moore: depends only on PS)
    always @(PS)
    begin
        case (PS)
            S4: z = 1;  // output high only when full sequence detected
            default: z = 0;
        endcase
    end

endmodule
