`timescale 1ns/1ps

module tb_integrated;

  // System signals
  logic clk, rst, scl, sda;
  
  // Combiner outputs
  logic sg_out;
  logic [7:0] buff_count;
  logic buff_full, bus_held, buff_empty;
  logic [1:0] invalid;
  
  // Separator outputs
  logic rx_done;
  logic [7:0] dout;
  logic rec_scl, rec_sda;
  
  // Clock period parameters
  parameter CLK_PERIOD = 10;   // 10 ns system clock period
  parameter SCL_PERIOD = 20;   // 20 ns I2C clock period
  
  // Instantiate the combiner module.
  combiner uut_combiner (
    .scl(scl),
    .sda(sda),
    .rst(rst),
    .clk(clk),
    .sg_out(sg_out),
    .buff_count(buff_count),
    .buff_full(buff_full),
    .bus_held(bus_held),
    .buff_empty(buff_empty),
    .invalid(invalid)
  );
  
  // Instantiate the separator module.
  // Its sg_in is driven directly by the combiner's output (sg_out).
  separator uut_separator (
    .clk(clk),
    .rst(rst),
    .sg_in(sg_out),
    .rx_done(rx_done),
    .dout(dout),
    .rec_sda(rec_sda),
    .rec_scl(rec_scl)
  );
  
  // Generate the system clock.
  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
  end
  
  // Generate the I2C clock (scl).
  initial begin
    scl = 1;
    forever #(SCL_PERIOD/2) scl = ~scl;
  end
  
  // Dump waveforms and monitor top-level signals.
  initial begin
    $dumpfile("integrated_tb.vcd");
    $dumpvars(0, tb_integrated);
    $monitor("Time=%0t | sda=%b, scl=%b, sg_out=%b, buff_count=%0d, buff_full=%b, buff_empty=%b, invalid=%b, rx_done=%b, dout=%h",
             $time, sda, scl, sg_out, buff_count, buff_full, buff_empty, invalid, rx_done, dout);
  end

  // Additional debug: Probe internal combiner signals every 50 ns.
  // (Ensure your simulation tool permits hierarchical access.)
  initial begin
    forever begin
      #50;
      $display("DEBUG: Time=%0t | combiner: start=%b, stop=%b, state=%b, bit_period=%0d",
               $time,
               uut_combiner.start_detected_reg,
               uut_combiner.stop_detected_reg,
               uut_combiner.state,
               uut_combiner.bit_period);
    end
  end

  // Integrated Test Sequence
  initial begin
    // Initialize signals.
    rst = 1;
    sda = 1;  // SDA idle high.
    #20;
    rst = 0;
    #20;
    
    // Send an 8-bit pattern via I2C-like transactions.
    // Pattern: 1,0,1,0,1,0,1,0 (expected to correspond to 0x55).
    i2c_start();
    i2c_send_bit(1);
    i2c_send_bit(0);
    i2c_send_bit(1);
    i2c_send_bit(0);
    i2c_send_bit(1);
    i2c_send_bit(0);
    i2c_send_bit(1);
    i2c_send_bit(0);
    i2c_stop();
    
    // Wait enough time for combiner to process the data and for the separator to decode.
    #2000;
    
    // Check the output from the separator.
    if (rx_done && (dout === 8'h55))
      $display("TEST PASSED: Received dout = %h at time %0t", dout, $time);
    else
      $display("TEST FAILED: Expected dout = 0x55, got %h at time %0t", dout, $time);
    
    $finish;
  end
  
  // Modified I2C Tasks
  
  // Generate a proper I2C start condition:
  // SDA goes from high to low while SCL is high, and we hold it for two SCL cycles.
  task i2c_start();
    begin
      sda = 1;
      @(posedge scl);
      sda = 0;               // Drive SDA low while SCL is high.
      repeat (2) @(posedge scl); // Hold start condition.
      $display("i2c_start executed at time %0t", $time);
    end
  endtask
  
  // Send a single bit. Hold the bit value for two SCL cycles so that the combiner can sample it.
  task i2c_send_bit(input logic bit_val);
    begin
      @(negedge scl);
      sda = bit_val;
      repeat (2) @(posedge scl);
      $display("Sent bit %b at time %0t", bit_val, $time);
    end
  endtask
  
  // Generate a proper I2C stop condition:
  // SDA goes from low to high while SCL is high, and hold for two SCL cycles.
  task i2c_stop();
    begin
      sda = 0;
      @(posedge scl);
      sda = 1;               // Drive SDA high while SCL is high.
      repeat (2) @(posedge scl);
      $display("i2c_stop executed at time %0t", $time);
    end
  endtask

endmodule
