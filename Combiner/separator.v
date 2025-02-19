`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2025 19:24:37
// Design Name: 
// Module Name: separator
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


module separator #(
    parameter DATA_SIZE=8,
    parameter START_PERIOD=5,
    parameter BIT1_PERIOD=20,
    parameter BIT0_PERIOD=10,
    parameter STOP_PERIOD=15 )
    (
    input wire clk,
    input wire rst,
    input wire sg_in,
    output reg rx_done,
    output reg [DATA_SIZE-1:0]dout,
    output reg rec_sda,
    output reg rec_scl
    );
    
    localparam STATE_IDLE=2'b00;
    localparam STATE_DATA=2'b01;
    localparam STATE_WAIT=2'b10;
    localparam STATE_STOP=2'b11;
    
    localparam TOTAL_BIT1 = START_PERIOD + BIT1_PERIOD; // 5 + 20 = 25 cycles for a '1'
    localparam TOTAL_BIT0 = START_PERIOD + BIT0_PERIOD; // 5 + 10 = 15 cycles for a '0'

    reg [1:0]state,next_state;
    reg [5:0]count,next_count;
    reg [$clog2(DATA_SIZE):0]bit_count,next_bit_count;
    reg current_bit;
    reg [5:0]bit_total;
    
    reg sg_in_d;
    always@(posedge clk or posedge rst) begin
        if(rst)
            sg_in_d<=1'b1;
        else
            sg_in_d<=sg_in;
    end
    
    always@(posedge clk or posedge rst) begin
        if(rst)begin
            state<=STATE_IDLE;
            count<=0;
            bit_count<=0;
            dout<=0;
            rx_done<=0;
            current_bit<=0;
            bit_total<=0;
            rec_scl<=0;
            rec_sda<=1;
        end else begin
            state<=next_state;
            count<=next_count;
            bit_count<=next_bit_count;
            
            if(state==STATE_DATA && count==(START_PERIOD-1))begin
                current_bit<=sg_in;
                if(sg_in)begin
                    bit_total<=TOTAL_BIT1; // Bit '1'
                end else begin
                    bit_total<=TOTAL_BIT0; // Bit '0'
                end
                rec_scl<=1; // generate a pulse at sampling instant
            end else begin
                rec_scl<=0;
            end
            
            if(state==STATE_WAIT && count==((bit_total-START_PERIOD)-1))begin
                dout<={current_bit,dout[DATA_SIZE-1:1]};
            end
            
            if(state==STATE_STOP && count==(STOP_PERIOD-1))
                rx_done<=1;
            else
                rx_done<=0;       
        end   
    end
    
    always @* begin
        next_state=state;
        next_count=count;
        next_bit_count=bit_count;
        case (state)
            STATE_IDLE: begin
                if((sg_in_d==1) && (sg_in==0)) begin
                    next_state=STATE_DATA;
                    next_count=0;
                    next_bit_count=0;
                end else begin
                    next_state=STATE_IDLE;
                    next_count=0;
                end
            end
            
            STATE_DATA: begin
                if(count==(START_PERIOD-1))begin
                    next_state=STATE_WAIT;
                    next_count=0;
                end else begin
                    next_state=STATE_DATA;
                    next_count=count+1;
                end
            end
            
            STATE_WAIT: begin
                if(count==((bit_total-START_PERIOD)-1))begin
                    next_bit_count=bit_count+1;
                    if(bit_count==(DATA_SIZE-1))
                        next_state=STATE_STOP;
                    else
                        next_state=STATE_DATA;
                    next_count=0;
                end else begin
                    next_state=STATE_WAIT;
                    next_count=count+1;
                end
            end
            
            STATE_STOP: begin
                if (count==(STOP_PERIOD-1)) begin
                    next_state=STATE_IDLE;
                    next_count=0;
                end else begin
                    next_state=STATE_STOP;
                    next_count=count+1;
                end
            end

            default: begin
                next_state=STATE_IDLE;
                next_count=0;
            end
        endcase
    end
endmodule
