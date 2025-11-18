`timescale 1ns / 1ps
//problem 4
module bin2bcd(
    input clk,
    input reset,
    input start,              // begin conversion
    input [11:0] bin_in,      // 12-bit binary input
    output reg [15:0] bcd_out, // 4 BCD digits (16 bits)
    output reg done            // high when complete
);

    // FSM state encoding
    parameter IDLE  = 3'b000,
              SETUP = 3'b001,
              ADD   = 3'b010,
              SHIFT = 3'b011,
              DONE  = 3'b100;

    reg [2:0] PS, NS;

    // Internal registers
    reg [27:0] bcd_data;      // {16-bit BCD, 12-bit binary}
    reg [3:0] shift_count;    // number of shifts performed
    reg [1:0] add_count;      // internal counter for add phase

    //========================
    // State register
    //========================
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            PS <= IDLE;
        else
            PS <= NS;
    end

    //========================
    // Next-state logic
    //========================
    always @(PS or start or shift_count or add_count or bcd_data)
    begin
        case (PS)
            IDLE: begin
                if (start)
                    NS = SETUP;
                else
                    NS = IDLE;
            end

            SETUP: begin
                NS = ADD;
            end

            ADD: begin
                if (add_count == 2'd3)
                    NS = SHIFT;
                else
                    NS = ADD;
            end

            SHIFT: begin
                if (shift_count == 4'd12)
                    NS = DONE;
                else
                    NS = ADD;
            end

            DONE: begin
                NS = IDLE;
            end

            default: NS = IDLE;
        endcase
    end

    //========================
    // Output and data logic
    //========================
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            bcd_data    <= 28'd0;
            shift_count <= 4'd0;
            add_count   <= 2'd0;
            bcd_out     <= 16'd0;
            done        <= 1'b0;
        end
        else
        begin
            case (PS)
                IDLE: begin
                    done <= 1'b0;
                end

                SETUP: begin
                    // load binary into lower bits of shift register
                    bcd_data    <= {16'd0, bin_in};
                    shift_count <= 4'd0;
                    add_count   <= 2'd0;
                    done        <= 1'b0;
                end

                ADD: begin
                    // Perform "add 3 if > 4" checks sequentially
                    if (bcd_data[15:12] > 4)
                        bcd_data[27:12] <= bcd_data[27:12] + 3;
                    if (bcd_data[19:16] > 4)
                        bcd_data[27:16] <= bcd_data[27:16] + 3;
                    if (bcd_data[23:20] > 4)
                        bcd_data[27:20] <= bcd_data[27:20] + 3;
                    if (bcd_data[27:24] > 4)
                        bcd_data[27:24] <= bcd_data[27:24] + 3;

                    // increment add counter
                    add_count <= add_count + 1;
                end

                SHIFT: begin
                    // left shift entire register
                    bcd_data <= bcd_data << 1;
                    shift_count <= shift_count + 1;
                    add_count <= 2'd0;
                end

                DONE: begin
                    bcd_out <= bcd_data[27:12];
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
