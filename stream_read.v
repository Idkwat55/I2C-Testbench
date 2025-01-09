module stream_read(
    input wire clk, rst, op_en,
    input wire [7:0] tdata,
    input wire tvalid,
    output reg tready,
    output reg [7:0] Dout,
    output reg data_available, empty
);

    reg [7:0] buffer [15:0];
    reg [3:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            tready <= 1;
            data_available <= 0;
            empty <= 1;
        end else begin
            if (op_en) begin

                empty <= (count == 0);
                data_available <= (count > 0);
                tready <= (count < 16);

                if (tvalid && tready) begin
                    buffer[count] <= tdata;
                    count <= count + 1;
                end

                if (data_available) begin
                    Dout <= buffer[count - 1];
                    count <= count - 1;
                end
                
            end else begin
                tready <= 0;
                data_available <= 0;
            end
        end
    end
endmodule