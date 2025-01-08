module stream_gen (
    input wire [7:0] Din,
    input wire push, clk, rst, op_en,
    output reg [3:0] buff_count,

    output reg [7:0] tdata,
    output reg tvalid,
    input wire tready,
    output reg tlast,

    output reg empty, full
);

    reg [7:0] buffer [15:0];
    reg [3:0] count; // Tracks the number of valid entries in the buffer

    reg push_reg, push_edge;

    // Push edge detection
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            push_reg <= 0;
            push_edge <= 0;
        end else begin
            push_edge <= push & ~push_reg; // Rising edge detection
            push_reg <= push;
        end
    end

    // Main logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tlast <= 0;
            tvalid <= 0;
            tdata <= 8'b0;
            count <= 0;

            full <= 0;
            empty <= 1;
        end else begin
            // Buffer status
            buff_count <= count;
            full <= (count == 15);
            empty <= (count == 0);

            if (op_en && tready) begin
                // Output mode
                if ( count > 0) begin
                    tdata <= buffer[count - 1]; // Read next data
                    tvalid <= 1;
                    count <= count - 1;

                    // Set tlast for the final word
                    if (count == 1) begin
                        tlast <= 1;
                    end else begin
                        tlast <= 0;
                    end
                end

                // Maintain stable output for 1000 cycles
                if (tvalid) begin

                    if (count == 0) begin
                        tvalid <= 0; // No more valid data
                    end

                end
            end else begin
                // Write mode
                tvalid <= 0;
                tlast <= 0;


                if (push_edge && !full) begin
                    buffer[count] <= Din; // Write new data
                    count <= count + 1;
                end
            end
        end
    end

endmodule
