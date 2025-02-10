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
// output line idle high
// transfers whats in buffer until its empty, then goes to stop condition and then idle
// clk must be 2x higher than scl

module combiner(
    input wire scl, input wire sda,
    input wire rst, input wire clk,
    output reg sg_out, // signal out
    output reg  [7:0] buff_count, // current amount of data still left inside buffer
    output reg buff_full, // Buffer is full
    output reg bus_held , // this module uses bus
    output reg buff_empty, // Buffer is empty
    output reg [1:0] invalid // to show various invalids or conditions
);

    reg [255:0] sda_buff;
    reg [8:0] sda_buff_wptr, sda_buff_rptr;
    reg [31:0] bit_period;
    reg start_detected_reg, stop_detected_reg;


    localparam  high_period =20, low_period = 10, start_period = 5, // low for 5 clocks, then start
    stop_period = 15, // low for 15 clocks then high
    invalid_period = 5,
    high = 1, low = 0,
    start_condition = 3'b000, transfer_high = 3'b001,
    transfer_low = 3'b010, stop_condition = 3'b011,
    idle_state = 3'b100, invalids = 3'b101;

    reg [2:0] invalid_reg;
    // Invalids
    // 101 - sda is neither 0 or 1
    // 010 - buffer empty but stop not detected 

    reg [2:0] state;
    reg busy;




    always @(posedge scl or posedge rst) begin
        if (rst) begin
            sda_buff_wptr <= 0;
            sda_buff_rptr <= 0;
            buff_full <= 0;
            buff_empty <= 0;
            buff_count <= 0;
        end
        if (start_detected_reg & !stop_detected_reg) begin
            if (!buff_full) begin
                sda_buff[sda_buff_wptr] <= sda;
                sda_buff_wptr <= (sda_buff_wptr + 1 == 255) ? 0 : sda_buff_wptr + 1;
            end

            buff_count <= sda_buff_wptr - sda_buff_rptr;

            if ( (sda_buff_wptr[8] ^ sda_buff_rptr[8]) && ( sda_buff_rptr[7:0] == sda_buff_wptr [7:0] ) ) begin
                buff_full <= 1;
            end
            else
                buff_full <= 0 ;

            if (sda_buff_wptr  == sda_buff_rptr) begin
                buff_empty <= 1;
            end
            else
                buff_empty <= 0 ;
        end
    end

    reg scl_reg = 0;

    always @(clk) begin
        scl_reg = scl;
    end


    // Sample SDA and SCL on the rising edge of the clock
    always @(negedge sda or posedge rst) begin
        if (rst) begin
            start_detected_reg = 0;
        end else if (scl == 1 && scl_reg == 1) begin
            start_detected_reg = 1;
            stop_detected_reg = 0;
        end
    end

    always @(posedge sda or posedge rst) begin
        if (rst) begin
            stop_detected_reg = 0;
        end else if (scl == 1 && scl_reg == 1) begin
            stop_detected_reg = 1;
            start_detected_reg = 0;
        end
    end




    always @(posedge clk or posedge rst) begin
        if   (rst) begin
            bit_period <= 0;
            state <= idle_state;
        end else   begin

            if (!buff_empty) begin

                case (state)
                    idle_state : begin
                        bus_held <= 0;
                        sg_out <= high;
                        busy <= 0;
                        if (start_detected_reg)
                            state <=start_condition;
                    end

                    start_condition : begin
                        bus_held <= 1;
                        busy <= 1;
                        sg_out <= low;
                        if (sda_buff[sda_buff_rptr] == high) begin
                            if (bit_period == start_period) begin
                                bit_period <= 0;
                                state <= transfer_high;
                                sda_buff_rptr <=  (sda_buff_rptr + 1 == 255 ) ? 0 : sda_buff_rptr + 1;
                            end else
                                bit_period <= bit_period + 1;
                        end
                        else if (sda_buff[sda_buff_rptr] == low) begin
                            if (bit_period == start_period) begin
                                bit_period <= 0;
                                state <= transfer_low;
                                sda_buff_rptr <= (sda_buff_rptr + 1 == 255 ) ? 0 : sda_buff_rptr + 1;
                            end else
                                bit_period <= bit_period + 1;
                        end else begin
                            state <= invalids;
                            bit_period <= 0;
                            invalid_reg <= 3'b101;
                        end
                    end



                    transfer_high : begin
                        sg_out <= high;
                        if (bit_period == high_period) begin
                            bit_period <= 0;
                            if (!buff_empty)
                                state <= start_condition;
                            else if ( buff_empty && stop_detected_reg)
                                state <= stop_condition;
                            else begin
                                state <= invalids;
                                bit_period <= 0;
                                invalid_reg <= 3'b010;
                            end
                        end
                        else
                            bit_period <= bit_period + 1;

                    end

                    transfer_low : begin
                        sg_out <= low;
                        if (bit_period == low_period) begin
                            bit_period <= 0;
                            if (!buff_empty)
                                state <= start_condition;
                            else if  (buff_empty && stop_detected_reg)
                                state <= stop_condition;
                            else  begin
                                state <= invalids;
                                bit_period <= 0;
                                invalid_reg <= 3'b010;
                            end
                        end
                        else
                            bit_period <= bit_period + 1;
                    end

                    stop_condition : begin
                        sg_out <= high;
                        if (bit_period == stop_period) begin
                            bit_period <= 0;
                            stop_detected_reg <= 0;
                            start_detected_reg <= 0;
                            state <= idle_state;
                        end
                        else
                            bit_period <= bit_period + 1;
                    end

                    invalids : begin
                        invalid <= invalid_reg;
                        //rst <= 1;
                        if (bit_period == invalid_period) begin
                            bit_period <= 0;
                            state <= idle_state;
                            // rst <= 0;
                        end
                        else begin
                            bit_period <= bit_period + 1;
                        end
                    end

                endcase


            end
        end
    end


endmodule
