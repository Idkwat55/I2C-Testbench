`timescale 1ns / 1ps
`default_nettype none

module manual_tb;
  // _g - global
  // _m - master
  // _s - slave
  reg clk_m1 = 0, clk_m2 = 0,
  clk_s1 =0, clk_s2 =0, clk_s3 =0,
  rst_m1 = 0, rst_m2 = 0,
  rst_s1 = 0, rst_s2 = 0, rst_s3 = 0;
  reg stop_on_idle_g = 0;

  reg FILTER_LEN = 'd4;

  // Master 1 Inputs
  reg [6:0] s_axis_cmd_address_m1 = 0;
  reg s_axis_cmd_start_m1 = 0;
  reg s_axis_cmd_read_m1 = 0;
  reg s_axis_cmd_write_m1 = 0;
  reg s_axis_cmd_write_multiple_m1 = 0;
  reg s_axis_cmd_stop_m1 = 0;
  reg s_axis_cmd_valid_m1 = 0;
  reg [7:0] s_axis_data_tdata_m1 = 0;
  reg s_axis_data_tvalid_m1 ;
  reg s_axis_data_tlast_m1 = 0;
  reg m_axis_data_tready_m1 ;
  reg scl_i_m1 = 1;
  reg sda_i_m1 = 1;
  reg [15:0] prescale_m1 = 0;
  reg stop_on_idle_m1 = 0;

  // Master 1 Outputs
  wire s_axis_cmd_ready_m1;
  wire s_axis_data_tready_m1;
  wire [7:0] m_axis_data_tdata_m1;
  wire m_axis_data_tvalid_m1;
  wire m_axis_data_tlast_m1;
  wire scl_o_m1;
  wire scl_t_m1;
  wire sda_o_m1;
  wire sda_t_m1;
  wire busy_m1;
  wire bus_control_m1;
  wire bus_active_m1;
  wire missed_ack_m1;

  // Master 2 Inputs
  reg [6:0] s_axis_cmd_address_m2 = 0;
  reg s_axis_cmd_start_m2 = 0;
  reg s_axis_cmd_read_m2 = 0;
  reg s_axis_cmd_write_m2 = 0;
  reg s_axis_cmd_write_multiple_m2 = 0;
  reg s_axis_cmd_stop_m2 = 0;
  reg s_axis_cmd_valid_m2 = 0;
  reg [7:0] s_axis_data_tdata_m2 = 0;
  reg s_axis_data_tvalid_m2 = 0;
  reg s_axis_data_tlast_m2 = 0;
  reg m_axis_data_tready_m2 = 0;
  reg scl_i_m2 = 1;
  reg sda_i_m2 = 1;
  reg [15:0] prescale_m2 = 0;
  reg stop_on_idle_m2 = 0;

  // Master 2 Outputs
  wire s_axis_cmd_ready_m2;
  wire s_axis_data_tready_m2;
  wire [7:0] m_axis_data_tdata_m2;
  wire m_axis_data_tvalid_m2;
  wire m_axis_data_tlast_m2;
  wire scl_o_m2;
  wire scl_t_m2;
  wire sda_o_m2;
  wire sda_t_m2;
  wire busy_m2;
  wire bus_control_m2;
  wire bus_active_m2;
  wire missed_ack_m2;

  // Slave 1 Inputs
  reg release_bus_s1 = 0;
  reg [7:0] s_axis_data_tdata_s1 = 0;
  reg s_axis_data_tvalid_s1 = 0;
  reg s_axis_data_tlast_s1 = 0;
  reg m_axis_data_tready_s1 = 0;
  reg scl_i_s1 = 1;
  reg sda_i_s1 = 1;
  reg enable_s1 = 0;
  reg [6:0] device_address_s1 = 0;
  reg [6:0] device_address_mask_s1 = 0;

  // Slave 1 Outputs
  wire s_axis_data_tready_s1;
  wire [7:0] m_axis_data_tdata_s1;
  wire m_axis_data_tvalid_s1;
  wire m_axis_data_tlast_s1;
  wire scl_o_s1;
  wire scl_t_s1;
  wire sda_o_s1;
  wire sda_t_s1;
  wire busy_s1;
  wire [6:0] bus_address_s1;
  wire bus_addressed_s1;
  wire bus_active_s1;

  // Slave 2 Inputs
  reg release_bus_s2 = 0;
  reg [7:0] s_axis_data_tdata_s2 = 0;
  reg s_axis_data_tvalid_s2 = 0;
  reg s_axis_data_tlast_s2 = 0;
  reg m_axis_data_tready_s2 = 0;
  reg scl_i_s2 = 1;
  reg sda_i_s2 = 1;
  reg enable_s2 = 0;
  reg [6:0] device_address_s2 = 0;
  reg [6:0] device_address_mask_s2 = 0;

  // Slave 2 Outputs
  wire s_axis_data_tready_s2;
  wire [7:0] m_axis_data_tdata_s2;
  wire m_axis_data_tvalid_s2;
  wire m_axis_data_tlast_s2;
  wire scl_o_s2;
  wire scl_t_s2;
  wire sda_o_s2;
  wire sda_t_s2;
  wire busy_s2;
  wire [6:0] bus_address_s2;
  wire bus_addressed_s2;
  wire bus_active_s2;

  // Slave 3 Inputs
  reg release_bus_s3 = 0;
  reg [7:0] s_axis_data_tdata_s3 = 0;
  reg s_axis_data_tvalid_s3 = 0;
  reg s_axis_data_tlast_s3 = 0;
  reg m_axis_data_tready_s3 = 0;
  reg scl_i_s3 = 1;
  reg sda_i_s3 = 1;
  reg enable_s3 = 0;
  reg [6:0] device_address_s3 = 0;
  reg [6:0] device_address_mask_s3 = 0;

  // Outputs
  wire s_axis_data_tready_s3;
  wire [7:0] m_axis_data_tdata_s3;
  wire m_axis_data_tvalid_s3;
  wire m_axis_data_tlast_s3;
  wire scl_o_s3;
  wire scl_t_s3;
  wire sda_o_s3;
  wire sda_t_s3;
  wire busy_s3;
  wire [6:0] bus_address_s3;
  wire bus_addressed_s3;
  wire bus_active_s3;

  i2c_master master1 (
    .clk(clk_m1),
    .rst(rst_m1),
    .s_axis_cmd_address(s_axis_cmd_address_m1),
    .s_axis_cmd_start(s_axis_cmd_start_m1),
    .s_axis_cmd_read(s_axis_cmd_read_m1),
    .s_axis_cmd_write(s_axis_cmd_write_m1),
    .s_axis_cmd_write_multiple(s_axis_cmd_write_multiple_m1),
    .s_axis_cmd_stop(s_axis_cmd_stop_m1),
    .s_axis_cmd_valid(s_axis_cmd_valid_m1),
    .s_axis_cmd_ready(s_axis_cmd_ready_m1),
    .s_axis_data_tdata(s_axis_data_tdata_m1),
    .s_axis_data_tvalid(s_axis_data_tvalid_m1),
    .s_axis_data_tready(s_axis_data_tready_m1),
    .s_axis_data_tlast(s_axis_data_tlast_m1),
    .m_axis_data_tdata(m_axis_data_tdata_m1),
    .m_axis_data_tvalid(m_axis_data_tvalid_m1),
    .m_axis_data_tready(m_axis_data_tready_m1),
    .m_axis_data_tlast(m_axis_data_tlast_m1),
    .scl_i(scl_i_m1),
    .scl_o(scl_o_m1),
    .scl_t(scl_t_m1),
    .sda_i(sda_i_m1),
    .sda_o(sda_o_m1),
    .sda_t(sda_t_m1),
    .busy(busy_m1),
    .bus_control(bus_control_m1),
    .bus_active(bus_active_m1),
    .missed_ack(missed_ack_m1),
    .prescale(prescale_m1),
    .stop_on_idle(stop_on_idle_m1)
  );

  i2c_master master2 (
    .clk(clk_m2),
    .rst(rst_m2),
    .s_axis_cmd_address(s_axis_cmd_address_m2),
    .s_axis_cmd_start(s_axis_cmd_start_m2),
    .s_axis_cmd_read(s_axis_cmd_read_m2),
    .s_axis_cmd_write(s_axis_cmd_write_m2),
    .s_axis_cmd_write_multiple(s_axis_cmd_write_multiple_m2),
    .s_axis_cmd_stop(s_axis_cmd_stop_m2),
    .s_axis_cmd_valid(s_axis_cmd_valid_m2),
    .s_axis_cmd_ready(s_axis_cmd_ready_m2),
    .s_axis_data_tdata(s_axis_data_tdata_m2),
    .s_axis_data_tvalid(s_axis_data_tvalid_m2),
    .s_axis_data_tready(s_axis_data_tready_m2),
    .s_axis_data_tlast(s_axis_data_tlast_m2),
    .m_axis_data_tdata(m_axis_data_tdata_m2),
    .m_axis_data_tvalid(m_axis_data_tvalid_m2),
    .m_axis_data_tready(m_axis_data_tready_m2),
    .m_axis_data_tlast(m_axis_data_tlast_m2),
    .scl_i(scl_i_m2),
    .scl_o(scl_o_m2),
    .scl_t(scl_t_m2),
    .sda_i(sda_i_m2),
    .sda_o(sda_o_m2),
    .sda_t(sda_t_m2),
    .busy(busy_m2),
    .bus_control(bus_control_m2),
    .bus_active(bus_active_m2),
    .missed_ack(missed_ack_m2),
    .prescale(prescale_m2),
    .stop_on_idle(stop_on_idle_m2)
  );

  i2c_slave slave1 (
    .clk(clk_s1),
    .rst(rst_s1),
    .release_bus(release_bus_s1),
    .s_axis_data_tdata(s_axis_data_tdata_s1),
    .s_axis_data_tvalid(s_axis_data_tvalid_s1),
    .s_axis_data_tready(s_axis_data_tready_s1),
    .s_axis_data_tlast(s_axis_data_tlast_s1),
    .m_axis_data_tdata(m_axis_data_tdata_s1),
    .m_axis_data_tvalid(m_axis_data_tvalid_s1),
    .m_axis_data_tready(m_axis_data_tready_s1),
    .m_axis_data_tlast(m_axis_data_tlast_s1),
    .scl_i(scl_i_s1),
    .scl_o(scl_o_s1),
    .scl_t(scl_t_s1),
    .sda_i(sda_i_s1),
    .sda_o(sda_o_s1),
    .sda_t(sda_t_s1),
    .busy(busy_s1),
    .bus_address(bus_address_s1),
    .bus_addressed(bus_addressed_s1),
    .bus_active(bus_active_s1),
    .enable(enable_s1),
    .device_address(device_address_s1),
    .device_address_mask(device_address_mask_s1)
  );

  i2c_slave slave2
  (
    .clk(clk_s2),
    .rst(rst_s2),
    .release_bus(release_bus_s2),
    .s_axis_data_tdata(s_axis_data_tdata_s2),
    .s_axis_data_tvalid(s_axis_data_tvalid_s2),
    .s_axis_data_tready(s_axis_data_tready_s2),
    .s_axis_data_tlast(s_axis_data_tlast_s2),
    .m_axis_data_tdata(m_axis_data_tdata_s2),
    .m_axis_data_tvalid(m_axis_data_tvalid_s2),
    .m_axis_data_tready(m_axis_data_tready_s2),
    .m_axis_data_tlast(m_axis_data_tlast_s2),
    .scl_i(scl_i_s2),
    .scl_o(scl_o_s2),
    .scl_t(scl_t_s2),
    .sda_i(sda_i_s2),
    .sda_o(sda_o_s2),
    .sda_t(sda_t_s2),
    .busy(busy_s2),
    .bus_address(bus_address_s2),
    .bus_addressed(bus_addressed_s2),
    .bus_active(bus_active_s2),
    .enable(enable_s2),
    .device_address(device_address_s2),
    .device_address_mask(device_address_mask_s2)
  );

  i2c_slave slave3
  (
    .clk(clk_s3),
    .rst(rst_s3),
    .release_bus(release_bus_s3),
    .s_axis_data_tdata(s_axis_data_tdata_s3),
    .s_axis_data_tvalid(s_axis_data_tvalid_s3),
    .s_axis_data_tready(s_axis_data_tready_s3),
    .s_axis_data_tlast(s_axis_data_tlast_s3),
    .m_axis_data_tdata(m_axis_data_tdata_s3),
    .m_axis_data_tvalid(m_axis_data_tvalid_s3),
    .m_axis_data_tready(m_axis_data_tready_s3),
    .m_axis_data_tlast(m_axis_data_tlast_s3),
    .scl_i(scl_i_s3),
    .scl_o(scl_o_s3),
    .scl_t(scl_t_s3),
    .sda_i(sda_i_s3),
    .sda_o(sda_o_s3),
    .sda_t(sda_t_s3),
    .busy(busy_s3),
    .bus_address(bus_address_s3),
    .bus_addressed(bus_addressed_s3),
    .bus_active(bus_active_s3),
    .enable(enable_s3),
    .device_address(device_address_s3),
    .device_address_mask(device_address_mask_s3)
  );

  always @(*) begin : scl_sda // for scl and sda bus / line
    scl_i_m1 = scl_o_m1 & scl_o_m2 & scl_o_s1 & scl_o_s2 & scl_o_s3;
    scl_i_m2 = scl_o_m1 & scl_o_m2 & scl_o_s1 & scl_o_s2 & scl_o_s3;
    scl_i_s1 = scl_o_m1 & scl_o_m2 & scl_o_s1 & scl_o_s2 & scl_o_s3;
    scl_i_s2 = scl_o_m1 & scl_o_m2 & scl_o_s1 & scl_o_s2 & scl_o_s3;
    scl_i_s3 = scl_o_m1 & scl_o_m2 & scl_o_s1 & scl_o_s2 & scl_o_s3;

    sda_i_m1 = sda_o_m1 & sda_o_m2 & sda_o_s1 & sda_o_s2 & sda_o_s3;
    sda_i_m2 = sda_o_m1 & sda_o_m2 & sda_o_s1 & sda_o_s2 & sda_o_s3;
    sda_i_s1 = sda_o_m1 & sda_o_m2 & sda_o_s1 & sda_o_s2 & sda_o_s3;
    sda_i_s2 = sda_o_m1 & sda_o_m2 & sda_o_s1 & sda_o_s2 & sda_o_s3;
    sda_i_s3 = sda_o_m1 & sda_o_m2 & sda_o_s1 & sda_o_s2 & sda_o_s3;
  end

  // for streamGen

  reg [7:0] streamGen_Din = 0 ;
  reg streamGen_push = 0 , streamGen_op_en = 0 ;
  reg streamGen_clk = 0, streamGen_rst = 0;

  wire streamGen_tready , streamGen_tlast ,
  streamGen_empty , streamGen_full , streamGen_tvalid ;

  wire  [3:0] streamGen_buff_count;
  wire [7:0] streamGen_tdata ;

  reg [2:0] streamGen_sel = 3'b000; // Clock selector for streamGen - 3'b000 is dedicated clk of streamGen
  // master1 = 3'd1 
  // master2 = 3'd2,
  // slave1  = 3'd3,
  // slave2  = 3'd4,
  // slave3  = 3'd5;
  reg [2:0] sel_mux = 3'b001; // Select muxDatagen_init_1    
  reg [2:0] sel_mux_2 = 3'b001; // Select muxDatagen_init_2
  reg streamGen_clk_sel = 0;
  reg streamGen_tready_reg = 0;

  always @(*) begin : stream_gen // for streamGen
    streamGen_tready_reg = streamGen_tready;
    case (streamGen_sel)
      3'b000: streamGen_clk_sel = streamGen_clk;
      3'b001: streamGen_clk_sel = clk_m1;
      3'b010: streamGen_clk_sel = clk_m2;
      3'b011: streamGen_clk_sel = clk_s1;
      3'b100: streamGen_clk_sel = clk_s2;
      3'b101: streamGen_clk_sel = clk_s3;
      default: streamGen_clk_sel = 1'b0; // Default case for invalid selection
    endcase
  end

  stream_gen streamGen (
    .Din(streamGen_Din),
    .push(streamGen_push), .clk(streamGen_clk_sel),
    .rst(streamGen_rst), .op_en(streamGen_op_en ),
    .buff_count(streamGen_buff_count),
    .tdata(streamGen_tdata ),
    .tvalid(streamGen_tvalid ),
    .tready(streamGen_tready_reg ),
    .tlast(streamGen_tlast ),
    .empty(streamGen_empty ),
    .full(streamGen_full)
  );

  // Intermediate wire for muxDatagen_init
  wire [7:0] s_axis_data_tdata_m1_w, s_axis_data_tdata_m2_w, s_axis_data_tdata_s1_w, s_axis_data_tdata_s2_w, s_axis_data_tdata_s3_w;
  wire s_axis_data_tvalid_m1_w, s_axis_data_tvalid_m2_w, s_axis_data_tvalid_s1_w, s_axis_data_tvalid_s2_w, s_axis_data_tvalid_s3_w;
  wire s_axis_data_tlast_m1_w, s_axis_data_tlast_m2_w, s_axis_data_tlast_s1_w, s_axis_data_tlast_s2_w, s_axis_data_tlast_s3_w;

  always @(*) begin : muxDatagen_init_pt1 // for muxDatagen_init
    s_axis_data_tdata_m1 = s_axis_data_tdata_m1_w;
    s_axis_data_tdata_m2 = s_axis_data_tdata_m2_w;
    s_axis_data_tdata_s1 = s_axis_data_tdata_s1_w;
    s_axis_data_tdata_s2 = s_axis_data_tdata_s2_w;
    s_axis_data_tdata_s3 = s_axis_data_tdata_s3_w;
    s_axis_data_tvalid_m1 = s_axis_data_tvalid_m1_w;
    s_axis_data_tvalid_m2 = s_axis_data_tvalid_m2_w;
    s_axis_data_tvalid_s1 = s_axis_data_tvalid_s1_w;
    s_axis_data_tvalid_s2 = s_axis_data_tvalid_s2_w;
    s_axis_data_tvalid_s3 = s_axis_data_tvalid_s3_w;
    s_axis_data_tlast_m1 = s_axis_data_tlast_m1_w;
    s_axis_data_tlast_m2 = s_axis_data_tlast_m2_w;
    s_axis_data_tlast_s1 = s_axis_data_tlast_s1_w;
    s_axis_data_tlast_s2 = s_axis_data_tlast_s2_w;
    s_axis_data_tlast_s3 = s_axis_data_tlast_s3_w;
  end

  // Intermediate reg for muxDatagen_init
  reg [7:0] streamGen_tdata_reg = 0;
  reg streamGen_tlast_reg = 0, streamGen_tvalid_reg = 0;
  reg s_axis_data_tready_m1_reg = 0, s_axis_data_tready_m2_reg = 0, s_axis_data_tready_s1_reg = 0, s_axis_data_tready_s2_reg = 0, s_axis_data_tready_s3_reg = 0;

  always @(*) begin : muxDatagen_init_pt2 // for muxDatagen_init
    streamGen_tdata_reg = streamGen_tdata;
    streamGen_tlast_reg = streamGen_tlast;
    streamGen_tvalid_reg = streamGen_tvalid;
    s_axis_data_tready_m1_reg = s_axis_data_tready_m1;
    s_axis_data_tready_m2_reg = s_axis_data_tready_m2;
    s_axis_data_tready_s1_reg = s_axis_data_tready_s1;
    s_axis_data_tready_s2_reg = s_axis_data_tready_s2;
    s_axis_data_tready_s3_reg = s_axis_data_tready_s3;
  end

  muxDataGen_w muxDatagen_w_1 (
    .sel(sel_mux),
    .tdata(streamGen_tdata_reg),
    .tvalid(streamGen_tvalid_reg),
    .tlast(streamGen_tlast_reg),
    .tready_m1(s_axis_data_tready_m1_reg), .tready_m2(s_axis_data_tready_m2_reg), .tready_s1(s_axis_data_tready_s1_reg),
    .tready_s2(s_axis_data_tready_s2_reg), .tready_s3(s_axis_data_tready_s3_reg),
    .tdata_m1(s_axis_data_tdata_m1_w), .tdata_m2(s_axis_data_tdata_m2_w), .tdata_s1(s_axis_data_tdata_s1_w),
    .tdata_s2(s_axis_data_tdata_s2_w), .tdata_s3(s_axis_data_tdata_s3_w),
    .tvalid_m1(s_axis_data_tvalid_m1_w), .tvalid_m2(s_axis_data_tvalid_m2_w), .tvalid_s1(s_axis_data_tvalid_s1_w),
    .tvalid_s2(s_axis_data_tvalid_s2_w), .tvalid_s3(s_axis_data_tvalid_s3_w),
    .tlast_m1(s_axis_data_tlast_m1_w), .tlast_m2(s_axis_data_tlast_m2_w), .tlast_s1(s_axis_data_tlast_s1_w),
    .tlast_s2(s_axis_data_tlast_s2_w), .tlast_s3(s_axis_data_tlast_s3_w),
    .tready(streamGen_tready)
  );

  muxDataGen_w muxDatagen_w_2 (
    .sel(sel_mux_2),
    .tdata(streamGen_tdata_reg),
    .tvalid(streamGen_tvalid_reg),
    .tlast(streamGen_tlast_reg),
    .tready_m1(s_axis_data_tready_m1_reg), .tready_m2(s_axis_data_tready_m2_reg), .tready_s1(s_axis_data_tready_s1_reg),
    .tready_s2(s_axis_data_tready_s2_reg), .tready_s3(s_axis_data_tready_s3_reg),
    .tdata_m1(s_axis_data_tdata_m1_w), .tdata_m2(s_axis_data_tdata_m2_w), .tdata_s1(s_axis_data_tdata_s1_w),
    .tdata_s2(s_axis_data_tdata_s2_w), .tdata_s3(s_axis_data_tdata_s3_w),
    .tvalid_m1(s_axis_data_tvalid_m1_w), .tvalid_m2(s_axis_data_tvalid_m2_w), .tvalid_s1(s_axis_data_tvalid_s1_w),
    .tvalid_s2(s_axis_data_tvalid_s2_w), .tvalid_s3(s_axis_data_tvalid_s3_w),
    .tlast_m1(s_axis_data_tlast_m1_w), .tlast_m2(s_axis_data_tlast_m2_w), .tlast_s1(s_axis_data_tlast_s1_w),
    .tlast_s2(s_axis_data_tlast_s2_w), .tlast_s3(s_axis_data_tlast_s3_w),
    .tready(streamGen_tready)
  );


  // Var for read mux
  reg [3:0] sel_mux_r_1 = 3'b001; // default master 1
  wire [7:0] streamRead_tdata_wire;
  wire streamRead_tvalid_wire, streamRead_tlast_wire;
  reg streamRead_tready_reg;

  wire m_axis_data_tready_m1_wire, m_axis_data_tready_m2_wire, m_axis_data_tready_s1_wire,
  m_axis_data_tready_s2_wire, m_axis_data_tready_s3_wire;
  reg [7:0] m_axis_data_tdata_m1_reg, m_axis_data_tdata_m2_reg, m_axis_data_tdata_s1_reg,
  m_axis_data_tdata_s2_reg, m_axis_data_tdata_s3_reg;
  reg m_axis_data_tvalid_m1_reg, m_axis_data_tvalid_m2_reg, m_axis_data_tvalid_s1_reg,
  m_axis_data_tvalid_s2_reg, m_axis_data_tvalid_s3_reg;
  reg m_axis_data_tlast_m1_reg, m_axis_data_tlast_m2_reg, m_axis_data_tlast_s1_reg,
  m_axis_data_tlast_s2_reg, m_axis_data_tlast_s3_reg;

  muxDataGen_r muxDataGen_r_1 (
    .sel(sel_mux_r_1),
    .tdata(streamRead_tdata_wire),
    .tvalid(streamRead_tvalid_wire),
    .tlast(streamRead_tlast_wire),
    .tready_m1(m_axis_data_tready_m1_wire), .tready_m2(m_axis_data_tready_m2_wire), .tready_s1(m_axis_data_tready_s1_wire),
    .tready_s2(m_axis_data_tready_s2_wire), .tready_s3(m_axis_data_tready_s3_wire),
    .tdata_m1(m_axis_data_tdata_m1_reg), .tdata_m2(m_axis_data_tdata_m2_reg), .tdata_s1(m_axis_data_tdata_s1_reg),
    .tdata_s2(m_axis_data_tdata_s2_reg), .tdata_s3(m_axis_data_tdata_s3_reg),
    .tvalid_m1(m_axis_data_tvalid_m1_reg), .tvalid_m2(m_axis_data_tvalid_m2_reg), .tvalid_s1(m_axis_data_tvalid_s1_reg),
    .tvalid_s2(m_axis_data_tvalid_s2_reg), .tvalid_s3(m_axis_data_tvalid_s3_reg),
    .tlast_m1(m_axis_data_tlast_m1_reg), .tlast_m2(m_axis_data_tlast_m2_reg), .tlast_s1(m_axis_data_tlast_s1_reg),
    .tlast_s2(m_axis_data_tlast_s2_reg), .tlast_s3(m_axis_data_tlast_s3_reg),
    .tready(streamRead_tready_reg)
  );

  // Vars for read 
  reg streamRead_rst = 0;
  reg [7:0] streamRead_tdata;
  reg streamRead_tvalid, streamRead_tlast;
  wire streamRead_tready, streamRead_data_out, streamRead_data_valid, streamRead_done;

  // Read module
  stream_read streamRead_init (
    .clk(streamGen_clk), .rst(streamRead_rst), // Clock and reset
    .tdata(streamRead_tdata), // Data from the source
    .tvalid(streamRead_tvalid), // Valid signal from the source
    .tlast(streamRead_tlast), // Last signal from the source
    .tready(streamRead_tready), // Ready signal to the source

    .data_out(streamRead_data_out), // Data output after read
    .data_valid(streamRead_data_valid), // Valid flag for the data_out
    .done(streamRead_done) // Indicates transfer is complete
  );

  always @(*) begin  : read_mux_1 // Assigning values to read_mux_1
    streamRead_tdata = streamRead_tdata_wire;
    streamRead_tvalid = streamRead_tvalid_wire;
    streamRead_tlast = streamRead_tlast_wire;
    streamRead_tready_reg = streamRead_tready;
    m_axis_data_tready_m1 = m_axis_data_tready_m1_wire;
    m_axis_data_tready_m2 = m_axis_data_tready_m2_wire;
    m_axis_data_tready_s1 = m_axis_data_tready_s1_wire;
    m_axis_data_tready_s2 = m_axis_data_tready_s2_wire;
    m_axis_data_tready_s3 = m_axis_data_tready_s3_wire;
    m_axis_data_tdata_m1_reg = m_axis_data_tdata_m1;
    m_axis_data_tdata_m2_reg = m_axis_data_tdata_m2;
    m_axis_data_tdata_s1_reg = m_axis_data_tdata_s1;
    m_axis_data_tdata_s2_reg = m_axis_data_tdata_s2;
    m_axis_data_tdata_s3_reg = m_axis_data_tdata_s3;
    m_axis_data_tvalid_m1_reg = m_axis_data_tvalid_m1;
    m_axis_data_tvalid_m2_reg = m_axis_data_tvalid_m2;
    m_axis_data_tvalid_s1_reg = m_axis_data_tvalid_s1;
    m_axis_data_tvalid_s2_reg = m_axis_data_tvalid_s2;
    m_axis_data_tvalid_s3_reg = m_axis_data_tvalid_s3;
    m_axis_data_tlast_m1_reg = m_axis_data_tlast_m1;
    m_axis_data_tlast_m2_reg = m_axis_data_tlast_m2;
    m_axis_data_tlast_s1_reg = m_axis_data_tlast_s1;
    m_axis_data_tlast_s2_reg = m_axis_data_tlast_s2;
    m_axis_data_tlast_s3_reg = m_axis_data_tlast_s3;
  end


  initial begin : clk_m1_gen
    clk_m1 = 0;
    // Clock gen
    // m1 - 10Mhz, m2 100Mhz, s1 20Mhz, s2 50 Mhz, s3 5Mhz
    forever
      begin
        clk_m1 = ~ clk_m1;
        #50;
      end
  end
  initial begin : clk_m2_gen
    clk_m2 = 0;
    forever
      begin
        clk_m2= ~ clk_m2;
        #5;
      end
  end
  initial begin : clk_s1_gen
    clk_s1 = 0;
    forever
      begin
        clk_s1= ~ clk_s1;
        #25;
      end
  end
  initial begin :clk_s2_gen
    clk_s2 = 0;
    forever
      begin
        clk_s2= ~ clk_s2;
        #10;
      end
  end
  initial begin :clk_s3_gen
    clk_s3 = 0;
    forever
      begin
        clk_s3= ~ clk_s3;
        #100;
      end
  end
  initial begin
    streamGen_clk = 0;
    forever begin
      streamGen_clk = ~ streamGen_clk;
      #1;
    end
  end

  reg [7:0] streamGen_Data_holder [1023:0]; // 1024 * 8 = 8192 bits = 1KiB
  reg [1023:0] insertData2_streamGen_current_count = 0, insertData2_streamGen_to_gen_OR_read = 0;
  reg insertData2_streamGen_busy = 0, insertData2_streamGen_done = 0 , insertData2_streamGen_icmd =0 ;

  task insertData2_streamGen  (

    input insertData2_streamGen_reset,
    insertData2_streamGen_write_data, // Write data to *_streamGen_Data_holder and streamGen buffer
    insertData2_streamGen_output_data, // Output data to modules from streamGen buffer

    output [1023:0] insertData2_streamGen_current_count, // *_current_count - keeps current pointer, doesnt mean data is altered in holder
    input  [1023:0] insertData2_streamGen_to_gen_OR_read, // How many byte to generate or output
    output insertData2_streamGen_busy, insertData2_streamGen_done, insertData2_streamGen_icmd // icmd - invalid command

  );
    // Internal variables
    reg [1023:0] tmp_count;
    reg [7:0] tmp_data;
    reg [3:0] tmp_original_clk_sel;
    integer tmp_count_int;

    tmp_original_clk_sel = streamGen_sel;
    streamGen_sel = 3'b000; // Select streamGen_clk 3'b000 is dedicated clk of streamGen

    if (insertData2_streamGen_reset) begin // Reset

      streamGen_rst = 1'b1;
      insertData2_streamGen_current_count = 0;
      #2;

    end
    else begin

      insertData2_streamGen_busy = 1'b1;

      if ( (insertData2_streamGen_output_data & (insertData2_streamGen_to_gen_OR_read > insertData2_streamGen_current_count)) | ( insertData2_streamGen_write_data & (insertData2_streamGen_current_count >= 'd1024) ) )
        insertData2_streamGen_icmd = 1'b1;
      else
        insertData2_streamGen_icmd = 1'b0;

      if (!insertData2_streamGen_icmd) begin
        insertData2_streamGen_done = 1'b0;
        tmp_count = 0;

        if (insertData2_streamGen_write_data) begin // Write - Generate data and store to *_streamGen_Data_holder

          for (tmp_count_int = 0; tmp_count_int < insertData2_streamGen_to_gen_OR_read; tmp_count_int = tmp_count_int + 1) begin

            tmp_data = $random;
            {streamGen_Din, streamGen_push, streamGen_rst, streamGen_op_en } = {tmp_data, 1'b1, 1'b0, 1'b0 } ;
            #2;
            streamGen_push = 1'b0;
            #2;
            streamGen_Data_holder[insertData2_streamGen_current_count + tmp_count] = tmp_data;
            tmp_count = tmp_count + 1;

          end
          insertData2_streamGen_current_count = insertData2_streamGen_current_count + tmp_count;
        end

        else if (insertData2_streamGen_output_data) begin
          tmp_count = streamGen_buff_count - insertData2_streamGen_to_gen_OR_read;
          while (streamGen_buff_count > tmp_count) begin
            {streamGen_push, streamGen_op_en} = {1'b0, 1'b1};
            #2;

          end
          insertData2_streamGen_current_count = insertData2_streamGen_current_count - insertData2_streamGen_to_gen_OR_read;
        end

      end

    end

    insertData2_streamGen_busy = 1'b0;
    insertData2_streamGen_done = 1'b1;
    streamGen_sel = tmp_original_clk_sel;

  endtask

  integer log_file;
  integer console;

  always @(insertData2_streamGen_to_gen_OR_read | insertData2_streamGen_busy | insertData2_streamGen_done | insertData2_streamGen_icmd) begin
    if (insertData2_streamGen_icmd)
      $fdisplay(console, "\t [%t][ Task ][ insertData2_streamGen ]  Invalid command for insertData2_streamGen ", $realtime);
    if (insertData2_streamGen_busy)
      $fdisplay(console, "\t [%t][ Task ][ insertData2_streamGen ]  Busy for insertData2_streamGen : Operating = %d bytes, buffer pointer = %d",
        $realtime, insertData2_streamGen_to_gen_OR_read, insertData2_streamGen_current_count);
    if (insertData2_streamGen_done)
      $fdisplay(console, "\t [%t][ Task ][ insertData2_streamGen ]  Done for insertData2_streamGen : Operating = %d bytes, buffer pointer = %d",
        $realtime, insertData2_streamGen_to_gen_OR_read, insertData2_streamGen_current_count);
  end



  initial

  begin : main_initial

    log_file = $fopen("Simulation.log");
    $timeformat(-9, 1, " ns", 4);

    // broadcast ( log + console
    console =   log_file | 32'b1;


    $fdisplay(console, "\t\t STARTED TESTBENCH [ Simulation Time : %t ] \t", $realtime);

    {rst_m1,rst_m2,rst_s1,rst_s2,rst_s3,streamGen_rst} = 6'b111111 ;

    $fdisplay(console,"\t [%t]  Reset  HIGH for \t m1 m2 s1 s2 s3 stream_gen", $realtime);

    #100;

    {rst_m1,rst_m2,rst_s1,rst_s2,rst_s3,streamGen_rst} = 6'b000000 ;

    $fdisplay(console,"\t [%t]  Reset  LOW  for \t m1 m2 s1 s2 s3 stream_gen", $realtime);

    #100;

    {enable_s1,enable_s2,enable_s3} = 3'b111;

    $fdisplay(console,"\t [%t]  Enable HIGH for \t       s1 s2 s3 ", $realtime);

    $fdisplay(console,"\t [%t]  SDA/SCL HIGH for \t m1 m2 s1 s2 s3 ", $realtime);

    #100;
    streamRead_rst = 1'b1;
    #2;
    streamRead_rst = 1'b0;

    // Slave 1
    device_address_s1 = 7'h22;

    // Slave 2
    device_address_s2 = 7'h55;

    // Slave 3
    device_address_s3 = 7'h37;

    {device_address_mask_s1, device_address_mask_s2, device_address_mask_s3} = {3{7'h7f}};

    $fdisplay(console,"\t [%t]  Slave 1 assigned Address : 0b%b (%d) \n\t [%t]  Slave 2 assigned Address : 0b%b (%d) \n\t [%t]  Slave 3 assigned Address : 0b%b (%d) ",
      $realtime, device_address_s1, device_address_s1, $realtime, device_address_s2, device_address_s2, $realtime, device_address_s3, device_address_s3);

    #100;

    prescale_m1 = 'd2;
    prescale_m2 = 'd2;
    stop_on_idle_m1 = 1'b1;
    stop_on_idle_m2 = 1'b1;
    #100;

    $fdisplay(console,"\t [%t]  Prescale set to 0b%b (%d) ", $realtime, prescale_m1, prescale_m1);
    $fdisplay(console,"\t [%t]  Stop_on_idle set to HIGH ", $realtime);

    /*  $fmonitor(console,"\t [Monitor] [stream_gen] : streamGen_Din = %b streamGen_push = %b , streamGen_op_en = %b, streamGen_rst = %b, \n\t                    ----  streamGen_tready = %b, streamGen_tlast = %b, streamGen_empty = %b, \n\t                    ----  streamGen_full = %b, streamGen_tvalid = %b, streamGen_buff_count = %b, streamGen_tdata = %b \n\t [%t]\n",
      streamGen_Din , streamGen_push , streamGen_op_en , streamGen_rst , streamGen_tready , streamGen_tlast ,
      streamGen_empty , streamGen_full , streamGen_tvalid , streamGen_buff_count , streamGen_tdata, $realtime);
    */

    // Write Multiple
    // Write to address 7'h22 , the data 0x11223344, from master 1
    // Load data to stream gen

    streamGen_rst = 1'b1;

    #4;

    streamGen_sel = 3'b000;

    sel_mux = 3'd001;
    insertData2_streamGen_to_gen_OR_read = 0;
    insertData2_streamGen (1'b1, 1'b0, 1'b0, insertData2_streamGen_current_count, insertData2_streamGen_to_gen_OR_read, insertData2_streamGen_busy, insertData2_streamGen_done, insertData2_streamGen_icmd);
    #2;
    insertData2_streamGen_to_gen_OR_read = 'd10;
    insertData2_streamGen(1'b0, 1'b1, 1'b0, insertData2_streamGen_current_count, insertData2_streamGen_to_gen_OR_read, insertData2_streamGen_busy, insertData2_streamGen_done, insertData2_streamGen_icmd);

    //     {streamGen_Din, streamGen_push, streamGen_rst, streamGen_op_en } = {8'h11, 1'b1, 1'b0, 1'b0 } ;
    //     #2;

    //     {streamGen_Din, streamGen_push, streamGen_rst, streamGen_op_en } = {8'h22, 1'b1, 1'b0, 1'b0 };
    //     #2;

    //     {streamGen_Din, streamGen_push, streamGen_rst, streamGen_op_en } = {8'h33, 1'b1, 1'b0, 1'b0 };
    //     #2;

    //     {streamGen_Din, streamGen_push, streamGen_rst, streamGen_op_en } = {8'h44, 1'b1, 1'b0, 1'b0 };
    //     #2;

    //     {streamGen_push, streamGen_op_en } = 3'b00;
    //     #2;

    streamGen_sel = 3'b001;
    #2;

    {s_axis_cmd_address_m1, s_axis_cmd_start_m1, s_axis_cmd_read_m1, s_axis_cmd_write_m1, s_axis_cmd_write_multiple_m1,
    s_axis_cmd_stop_m1} = {7'h22, 1'b0, 1'b0,  1'b0 ,    1'b1, 1'b1};

    //                      Addr, start, read, write, write_m, stop
    s_axis_data_tdata_m1 = 8'h00;

    // Start pushing data
    insertData2_streamGen(1'b1, 1'b0, 1'b1, insertData2_streamGen_current_count, 'd5, insertData2_streamGen_busy, insertData2_streamGen_done, insertData2_streamGen_icmd);

    //streamGen_op_en = 1'b1;
    s_axis_cmd_valid_m1 = 1'b1;

    #100 ; // Sync to Master 1 - 2 clocks 
    s_axis_cmd_valid_m1 = 1'b0;
    $stop;
    //  #100_00_00;

    // Annouce END & Close files

    $fdisplay(console, "\n\t\t  END OF TEST [ Simulation time : %t ] \t", $realtime);
    $fdisplay(console, "\n\t\t  Log file is generated at pwd/Simulation_LOG.log");
    $fdisplay(console, "\t\t  VCD file is generated at pwd/Simulation_dump.vcd \n");

    $dumpfile("Simulation_dump.vcd");
    $dumpvars(0,manual_tb);

    $fclose(log_file);

    //$finish;

  end

endmodule
