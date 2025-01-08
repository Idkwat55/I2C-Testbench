`timescale 1ns / 1ps


module manual_tb;
  // _g - global
  // _m - master
  // _s - slave
  reg clk_m1 = 0, clk_m2 = 0,
  clk_s1 =0, clk_s2 =0, clk_s3 =0,
  rst_m1 = 0, rst_m2 = 0,
  rst_s1 = 0, rst_s2 = 0, rst_s3 = 0;
  reg [15:0] prescale_g = 0;
  reg stop_on_idle_g = 0;

  reg FILTER_LEN = 'd4;

  // Maaster 1 Inputs
  reg [6:0] s_axis_cmd_address_m1 = 0;
  reg s_axis_cmd_start_m1 = 0;
  reg s_axis_cmd_read_m1 = 0;
  reg s_axis_cmd_write_m1 = 0;
  reg s_axis_cmd_write_multiple_m1 = 0;
  reg s_axis_cmd_stop_m1 = 0;
  reg s_axis_cmd_valid_m1 = 0;
  reg [7:0] s_axis_data_tdata_m1 = 0;
  reg s_axis_data_tvalid_m1 = 0;
  reg s_axis_data_tlast_m1 = 0;
  reg m_axis_data_tready_m1 = 0;
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

  // Maaster 2 Inputs
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


  assign scl_o_m1 = scl_i_m1 & scl_i_m2 & scl_i_s1 & scl_i_s2 & scl_i_s3;
  assign scl_o_m2 = scl_i_m1 & scl_i_m2 & scl_i_s1 & scl_i_s2 & scl_i_s3;
  assign scl_o_s1 = scl_i_m1 & scl_i_m2 & scl_i_s1 & scl_i_s2 & scl_i_s3;
  assign scl_o_s2 = scl_i_m1 & scl_i_m2 & scl_i_s1 & scl_i_s2 & scl_i_s3;
  assign scl_o_s3 = scl_i_m1 & scl_i_m2 & scl_i_s1 & scl_i_s2 & scl_i_s3;

  assign sda_o_m1 = sda_i_m1 & sda_i_m2 & sda_i_s1 & sda_i_s2 & sda_i_s3;
  assign sda_o_m2 = sda_i_m1 & sda_i_m2 & sda_i_s1 & sda_i_s2 & sda_i_s3;
  assign sda_o_s1 = sda_i_m1 & sda_i_m2 & sda_i_s1 & sda_i_s2 & sda_i_s3;
  assign sda_o_s2 = sda_i_m1 & sda_i_m2 & sda_i_s1 & sda_i_s2 & sda_i_s3;
  assign sda_o_s3 = sda_i_m1 & sda_i_m2 & sda_i_s1 & sda_i_s2 & sda_i_s3;

  reg [7:0] streamGen_Din ;
  reg streamGen_push , streamGen_op_en ;
  reg streamGen_clk, streamGen_rst;
  wire streamGen_tready , streamGen_tlast ,
  streamGen_empty , streamGen_full , streamGen_tvalid ;
  wire  [3:0] streamGen_buff_count ;
  wire [7:0] streamGen_tdata;
  reg [2:0] sel_mux;


  stream_gen streamGen (
    .Din(streamGen_Din),
    .push(streamGen_push), .clk(streamGen_clk), .rst(streamGen_rst), .op_en(streamGen_op_en ),
    .buff_count(streamGen_buff_count ),
    .tdata(streamGen_tdata ),
    .tvalid(streamGen_tvalid ),
    .tready(streamGen_tready ),
    .tlast(streamGen_tlast ),
    .empty(streamGen_empty ),
    .full(streamGen_full)
  );

  muxDataGen muxDatagen_init (
    .sel(sel_mux),
    .tdata(streamGen_tdata),
    .tvalid(streamGen_tvalid),
    .tlast(streamGen_tlast),
    .tready_m1(s_axis_data_tready_m1), .tready_m2(s_axis_data_tready_m2), .tready_s1(s_axis_data_tready_s1),
    .tready_s2(s_axis_data_tready_s2), .tready_s3(s_axis_data_tready_s3),
    .tdata_m1(s_axis_data_tdata_m1), .tdata_m2(s_axis_data_tdata_m2), .tdata_s1(s_axis_data_tdata_s1),
    .tdata_s2(s_axis_data_tdata_s2), .tdata_s3(s_axis_data_tdata_s3),
    .tvalid_m1(s_axis_data_tvalid_m1), .tvalid_m2(s_axis_data_tvalid_m2), .tvalid_s1(s_axis_data_tvalid_s1),
    .tvalid_s2(s_axis_data_tvalid_s2), .tvalid_s3(s_axis_data_tvalid_s3),
    .tlast_m1(s_axis_data_tlast_m1), .tlast_m2(s_axis_data_tlast_m1), .tlast_s1(s_axis_data_tlast_m1),
    .tlast_s2(s_axis_data_tlast_m1),.tlast_s3(s_axis_data_tlast_m1),
    .tready(streamGen_tready)
  );







  integer i;

  initial
  begin : clock_gen
    clk_m1 = 0;
    clk_m2 = 0;
    clk_s1 = 0;
    clk_s2 = 0;
    clk_s3 = 0;
    // Clock gen
    // m1 - 10Mhz, m2 100Mhz, s1 20Mhz, s2 50 Mhz, s3 5Mhz
    forever
      begin
        clk_m1 = ~ clk_m1;
        #50;
      end
    forever
      begin
        clk_m2= ~ clk_m2;
        #5;
      end
    forever
      begin
        clk_s1= ~ clk_s1;
        #25;
      end
    forever
      begin
        clk_s2= ~ clk_s2;
        #10;
      end
    forever
      begin
        clk_s2= ~ clk_s2;
        #100;
      end


  end

  initial
  begin : main_initial


    integer log_file;
    integer console;

    //sf

    // Open files for producer and consumer
    log_file = $fopen("LOG_FILE.log");


    // Combine files for broadcast
    console = log_file  | 32'b1;


    // Log final message to both files
    $fdisplay(console, "\t\t STARTED TESTBENCH [ Simulation Time :%t ns/ps ] \t", $time);

    {rst_m1,rst_m2,rst_s1,rst_s2,rst_s3} = 5'b11111 ;
    $fdisplay(console,"\t [testbench] Reset HIGH for m1 m2 s1 s2 s3 ");
    #100;
    {rst_m1,rst_m2,rst_s1,rst_s2,rst_s3} = 5'b00000 ;
    $fdisplay(console,"\t [testbench] Reset LOW for m1 m2 s1 s2 s3 ");
    #100;
    {enable_s1,enable_s2,enable_s3} = 3'b111;
    $fdisplay(console,"\t [testbench] Enable HIGH for     s1 s2 s3 ");
    // Slave 1
    device_address_s1 = 7'h22;
    device_address_mask_s1 = 7'h7f;
    // Slave 2
    device_address_s2 = 7'h2a;
    device_address_mask_s2 = 7'h7f;
    // Slave 3
    device_address_s2 = 7'h37;
    device_address_mask_s2 = 7'h7f;

    $fdisplay(console,"\t [testbench]  Slave 1 assigned Address : 0b%b \n\t [testbench]  Slave 2 assigned Address : 0b%b \n\t [testbench]  Slave 3 assigned Address : 0b%b",
    device_address_s1, device_address_s2, device_address_s3);
    #100;
    prescale_m1 = 'd2; prescale_m2 = 'd2;
    $fdisplay(console,"\t [testbench] Prescale set to 0b%b", prescale_m1);

    // Close files
    $fdisplay(console, "\t\t END OF TEST [ Simulation tIme : %t ns/ps ] \t", $time);
    $fclose(log_file);

  end

endmodule
