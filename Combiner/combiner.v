`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2025 18:13:28
// Design Name: 
// Module Name: walsh_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// 1 - 20 ns, 0 - 10 ns  on a 100Mhz clock


module combiner(
    input wire scl, input wire sda,
    input wire rst, input wire clk,
    input wire op_en, // buffer to sg_out
    input wire wen, // sda to buffer
    output reg sg_out, // signal out
    output reg  [7:0] buff_count, // current amount of data still left inside buffer
    output reg buff_overflow, // Buffer is full
    output reg bus_held , // this module uses bus
    output reg buff_empty // Buffer is empty
);

    reg [7:0] sda_buff;
    reg [7:0] sda_buff_wptr, sda_buff_rptr;
    reg [31:0] bit_period;
    reg start_done, stop_done;

    localparam  high_period =20, low_period = 10, start_period = 5, // low for 5 clocks, then start
    stop_period = 15, // low for 15 clocks then high
    high = 1, low = 0;



    always @(posedge rst) begin
        sda_buff_wptr = 0;
        sda_buff_rptr = 0;
        bit_period = 0;
        buff_count = 0;
        sg_out <= 1;
        buff_overflow = 0;
        buff_empty = 0;
        start_done = 0;
        stop_done = 0;
    end

    always @(posedge scl) begin
        if (wen) begin
            sda_buff[sda_buff_wptr] = sda;
            sda_buff_wptr = sda_buff_wptr + 1;

            buff_count = sda_buff_wptr - sda_buff_rptr;
            if (buff_count == 255) begin
                buff_overflow = 1;
            end
            else
                buff_overflow = 0;
            if (buff_count == 0) begin
                buff_empty = 1;
            end
            else
                buff_empty = 0;
        end
    end

    always @(posedge clk) begin
        if (op_en) begin

            if (!buff_empty) begin
                if (!start_done) begin
                    sg_out <= low;
                    if (bit_period == start_period) begin
                        start_done = 0;
                        stop_done = 1;
                    end
                    else
                        bit_period = bit_period + 1;
                end
                else if (sda_buff[sda_buff_rptr] == high) begin

                    sg_out <= high;
                    bus_held <= 1;
                    if ( bit_period == high_period) begin
                        sda_buff_rptr <= sda_buff_rptr + 1;
                        bus_held <= 0;
                        bit_period = 0;
                    end else
                        bit_period = bit_period + 1;
                end
                else if (sda_buff[sda_buff_rptr] == low) begin
                    sg_out <= low;
                    bus_held <= 1;
                    if (bit_period == low_period) begin
                        sda_buff_rptr <= sda_buff_rptr + 1;
                        bit_period = 0;
                        bus_held <= 0;
                    end
                    else
                        bit_period = bit_period + 1;
                end

            end
            else if (buff_empty) begin
                if (stop_done) begin
                    sg_out <= high;
                    if (bit_period == stop_period) begin
                        stop_done = 0;
                        start_done = 1;
                    end
                    else
                        bit_period = bit_period + 1;
                end
            end
        end
    end


endmodule
