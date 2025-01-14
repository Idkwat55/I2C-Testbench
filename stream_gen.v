module stream_gen (
    input wire [7:0] Din, // Data input
    input wire push, clk, rst, op_en, // Control signals
    input wire tready, // Ready signal from receiver

    output reg [3:0] buff_count, // Tracks the number of valid entries in the buffer
    output reg [7:0] tdata, // Data to be transmitted
    output reg tvalid, // Data validity signal
    output reg tlast, // Indicates last piece of data
    output reg empty, full // Buffer status
);

    reg [7:0] buffer [15:0]; // Buffer to hold 16 8-bit data entries
    reg [3:0] count, rptr, wptr; // Count of valid entries in the buffer

    // Main process: handles data reading, writing, and buffer management
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic: clear all registers and buffer status
            tlast <= 0;
            tvalid <= 0;
            tdata <= 8'b0;
            count <= 0;
            buff_count <= 0;
            full <= 0;
            empty <= 1;
            rptr <= 0;
            wptr <= 0;
        end else begin
            // Update buffer count and status signals
            buff_count = count;
            full <= (count == 15); // Full when count reaches 15
            empty <= (count == 0); // Empty when count is 0

            if (rptr >= wptr) begin

                rptr <= 0;
                wptr <= 0;
            end

            if (op_en && tready) begin
                // Output mode: read data from buffer and send to output
                if (count > 0) begin
                    tdata <= buffer[rptr]; // Read next data from the buffer
                    tvalid <= 1; // Data is valid
                    buff_count <= wptr - rptr ;
                    rptr <= rptr + 1; // Increment the read pointer
                    count <= count - 1; // Decrement the count

                    // If this is the last valid data, set tlast
                    if (count == 1) begin
                        tlast <= 1;
                    end else begin
                        tlast <= 0;
                    end
                end

                // Disable tvalid when no data is left to send
                if (tvalid && count == 0) begin
                    tvalid <= 0;
                    tlast <= 0; // Clear tlast as no more data will be sent
                end
            end else if (!op_en) begin
                // Write mode: write data into the buffer when 'push' is high and buffer is not full
                tvalid <= 0; // Disable tvalid during write mode
                tlast <= 0; // Reset tlast during write mode

                if (push && !full) begin
                    buffer[count] <= Din; // Write data into the buffer
                    count <= count + 1; // Increment the buffer count
                    wptr <= wptr + 1; // Increment the write pointer
                    buff_count <= count;
                end
            end
        end
    end

endmodule
