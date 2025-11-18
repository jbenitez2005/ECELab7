`timescale 1ns / 1ps
//probelm 5
module multiseg_display(
    input clk,
    input reset,
    input [15:0] bcd,     // four BCD digits: [15:12][11:8][7:4][3:0]
    output reg [6:0] seg,
    output reg [3:0] an
);
    reg [1:0] digit_sel;
    reg [3:0] current_digit;
    reg [15:0] refresh_counter;

    // Simple refresh clock
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end

    // Choose which digit to display
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            digit_sel <= 0;
        else
            digit_sel <= refresh_counter[15:14];
    end

    // Select digit data
    always @(*)
    begin
        case (digit_sel)
            2'b00: begin an = 4'b1110; current_digit = bcd[3:0];   end
            2'b01: begin an = 4'b1101; current_digit = bcd[7:4];   end
            2'b10: begin an = 4'b1011; current_digit = bcd[11:8];  end
            2'b11: begin an = 4'b0111; current_digit = bcd[15:12]; end
            default: begin an = 4'b1111; current_digit = 4'd0; end
        endcase
    end

    // Convert nibble to 7-segment code (active-low)
    always @(*)
    begin
        case (current_digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule
