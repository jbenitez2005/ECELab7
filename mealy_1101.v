`timescale 1ns / 1ps
//problem 2
module mealy_1101(
    input clk,
    input reset,
    input x,          // serial input
    output reg z      // output high when 1101 detected
);

    // State encoding (4 states)
    parameter S0 = 2'b00,   // initial
              S1 = 2'b01,   // got 1
              S2 = 2'b10,   // got 11
              S3 = 2'b11;   // got 110

    reg [1:0] PS, NS;

    // State Register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            PS <= S0;
        else
            PS <= NS;
    end

    // Next-State and Output Logic
    always @(PS or x)
    begin
        z = 0;   // default output
        case (PS)
            S0: begin
                if (x)
                    NS = S1;    // saw first 1
                else
                    NS = S0;
            end

            S1: begin
                if (x)
                    NS = S2;    // saw 11
                else
                    NS = S0;
            end

            S2: begin
                if (x)
                    NS = S2;    // stay on consecutive 1s
                else
                    NS = S3;    // saw 110
            end

            S3: begin
                if (x) begin
                    NS = S1;    // saw 1101 → overlap “1”
                    z = 1;      // output 1 immediately (Mealy)
                end
                else
                    NS = S0;
            end

            default: NS = S0;
        endcase
    end

endmodule
