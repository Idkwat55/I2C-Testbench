module muxDataGen_w (
  input wire [2:0] sel,
  input wire [7:0] tdata,
  input wire tvalid,
  input wire tlast,
  input wire tready_m1, tready_m2, tready_s1, tready_s2, tready_s3,

  output reg [7:0] tdata_m1, tdata_m2, tdata_s1, tdata_s2, tdata_s3,
  output reg tvalid_m1, tvalid_m2, tvalid_s1, tvalid_s2, tvalid_s3,
  output reg tlast_m1, tlast_m2, tlast_s1, tlast_s2, tlast_s3,
  output reg tready
);

  // Local parameters for selection
  localparam master1 = 3'd1,
  master2 = 3'd2,
  slave1  = 3'd3,
  slave2  = 3'd4,
  slave3  = 3'd5;

  always @(*)
  begin


    // Routing based on selection
    case (sel)
      master1:
      begin
        tdata_m1 = tdata;
        tdata_m2 = 8'd0;
        tdata_s1 = 8'd0;
        tdata_s2 = 8'd0;
        tdata_s3 = 8'd0;
        tvalid_m1 = tvalid;
        tvalid_m2 = 1'b0;
        tvalid_s1 = 1'b0;
        tvalid_s2 = 1'b0;
        tvalid_s3 = 1'b0;
        tlast_m1 = tlast;
        tlast_m2 = 1'b0;
        tlast_s1 = 1'b0;
        tlast_s2 = 1'b0;
        tlast_s3 = 1'b0;
        tready = tready_m1;
      end

      master2:
      begin
        tdata_m1 = 8'd0;
        tdata_m2 = tdata;
        tdata_s1 = 8'd0;
        tdata_s2 = 8'd0;
        tdata_s3 = 8'd0;
        tvalid_m1 = 1'b0;
        tvalid_m2 = tvalid;
        tvalid_s1 = 1'b0;
        tvalid_s2 = 1'b0;
        tvalid_s3 = 1'b0;
        tlast_m1 =  1'b0;
        tlast_m2 = tlast;
        tlast_s1 = 1'b0;
        tlast_s2 = 1'b0;
        tlast_s3 = 1'b0;
        tready = tready_m2;
      end

      slave1:
      begin
        tdata_m1 = 8'd0;
        tdata_m2 =  8'd0;
        tdata_s1 = tdata;
        tdata_s2 = 8'd0;
        tdata_s3 = 8'd0;
        tvalid_m1 = 1'b0;
        tvalid_m2 = 1'b0;
        tvalid_s1 = tvalid;
        tvalid_s2 = 1'b0;
        tvalid_s3 = 1'b0;
        tlast_m1 =  1'b0;
        tlast_m2 = 1'b0;
        tlast_s1 = tlast;
        tlast_s2 = 1'b0;
        tlast_s3 = 1'b0;
        tready = tready_s1;
      end

      slave2:
      begin
        tdata_m1 = 8'd0;
        tdata_m2 =  8'd0;
        tdata_s1 = 8'd0;
        tdata_s2 = tdata;
        tdata_s3 = 8'd0;
        tvalid_m1 = 1'b0;
        tvalid_m2 = 1'b0;
        tvalid_s1 = 1'b0;
        tvalid_s2 = tvalid;
        tvalid_s3 = 1'b0;
        tlast_m1 =  1'b0;
        tlast_m2 = 1'b0;
        tlast_s1 = 1'b0;
        tlast_s2 = tlast;
        tlast_s3 = 1'b0;
        tready = tready_s2;
      end

      slave3:
      begin
        tdata_m1 = 8'd0;
        tdata_m2 =  8'd0;
        tdata_s1 = 8'd0;
        tdata_s2 = 8'd0;
        tdata_s3 = tdata;
        tvalid_m1 = 1'b0;
        tvalid_m2 = 1'b0;
        tvalid_s1 = 1'b0;
        tvalid_s2 = 1'b0;
        tvalid_s3 = tvalid;
        tlast_m1 =  1'b0;
        tlast_m2 = 1'b0;
        tlast_s1 = 1'b0;
        tlast_s2 = 1'b0;
        tlast_s3 = tlast;
        tready = tready_s3;
      end

      default:
      begin
        // Default values for outputs
        tdata_m1 = 8'd0;
        tdata_m2 = 8'd0;
        tdata_s1 = 8'd0;
        tdata_s2 = 8'd0;
        tdata_s3 = 8'd0;
        tvalid_m1 = 1'b0;
        tvalid_m2 = 1'b0;
        tvalid_s1 = 1'b0;
        tvalid_s2 = 1'b0;
        tvalid_s3 = 1'b0;
        tlast_m1 = 1'b0;
        tlast_m2 = 1'b0;
        tlast_s1 = 1'b0;
        tlast_s2 = 1'b0;
        tlast_s3 = 1'b0;
        tready = 1'b0;
      end
    endcase
  end

endmodule
