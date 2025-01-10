module stream_read (
    input wire clk, rst, // Clock and reset
    input wire [7:0] tdata, // Data from the source
    input wire tvalid, // Valid signal from the source
    input wire tlast, // Last signal from the source
    output reg tready, // Ready signal to the source

    output reg [7:0] data_out, // Data output after read
    output reg data_valid, // Valid flag for the data_out
    output reg done // Indicates transfer is complete
);

    reg [2:0] clk_count; // Counter for clock cycles
    reg reading; // Indicates if the module is actively reading
    reg tlast_detected; // Tracks if tlast has been detected

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tready <= 0;
            data_out <= 8'b0;
            data_valid <= 0;
            done <= 0;
            clk_count <= 0;
            reading <= 0;
            tlast_detected <= 0;
        end else begin
            if (!reading) begin
                // Signal readiness by toggling tready high
                tready <= 1;
                if (tvalid && tready) begin
                    reading <= 1; // Start reading process
                    clk_count <= 0; // Reset counter
                    tready <= 0; // Pull tready low
                    tlast_detected <= tlast; // Capture tlast status
                end
            end else begin
                if (!tlast)
                    tlast_detected <= 0;
                    // Wait 4 clock cycles to simulate processing
                if (!tlast_detected) begin
                    clk_count <= clk_count + 1;
                    if (clk_count == 4) begin
                        if (tvalid) begin
                            data_out <= tdata; // Capture data
                            data_valid <= 1; // Signal valid data
                        end

                        if (tlast_detected) begin
                            done <= 1; // Indicate transfer is complete
                        end

                        tready <= 1; // Signal readiness for new data
                        reading <= 0; // Stop reading process
                    end
                end
            end


            // Reset data_valid for the next read cycle
            if (!reading && data_valid) begin
                data_valid <= 0;
            end

            // Reset done signal after 1 clock cycle
            if (done) begin
                done <= 0;
            end
        end
    end
endmodule
