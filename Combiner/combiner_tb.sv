`timescale 1ns / 1ps

module tb_combiner();
    reg scl, sda, rst, clk;
    wire sg_out;
    wire [7:0] buff_count;
    wire buff_full, bus_held, buff_empty;
    wire [1:0] invalid;

    combiner dut (
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

  
    parameter SCL_PERIOD = 20;  
    parameter CLK_PERIOD = 10;   
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        scl = 1;
        forever #(SCL_PERIOD/2) scl = ~scl;
    end

    
    initial begin
        $dumpfile("combiner_tb.vcd");
        $dumpvars(0, tb_combiner);
        
        initialize();
        test_reset();
        test_single_bit();
        test_multiple_bits();
        test_buffer_overflow();
        test_stop_condition();
        test_invalid_data();
        
        $display("\nAll tests completed!");
        $finish;
    end

    task initialize;
    begin
        rst = 1;
        sda = 1;
        #20 rst = 0;
    end
    endtask

    task test_reset;
    begin
        $display("\nReset Test");
        rst = 1;
        #10;
        if (buff_count !== 0 || buff_full !== 0 || buff_empty !== 1) begin
            $error("Reset failed");
        end
        #10 rst = 0;
    end
    endtask

    task test_single_bit;
    begin
        $display("\nSingle Bit Transfer");
        i2c_start();
        i2c_send_bit(1);
        i2c_stop();
        
        #50;
        if (buff_count !== 1) $error("Buffer count mismatch");
    end
    endtask

    task test_multiple_bits;
    begin
        $display("\nMultiple Bit Transfer");
        i2c_start();
        i2c_send_bit(1);
        i2c_send_bit(0);
        i2c_send_bit(1);
        i2c_send_bit(0);
        i2c_stop();
        
        #50;
        if (buff_count !== 4) $error("Buffer count mismatch");
    end
    endtask

    task test_buffer_overflow;
    begin
        $display("\nBuffer Overflow");
        i2c_start();
        repeat(260) i2c_send_bit($random);
        i2c_stop();
        
        #50;
        if (!buff_full) $error("Buffer full not detected");
    end
    endtask

    task test_stop_condition;
    begin
        $display("\nStop Condition");
        i2c_start();
        i2c_send_bit(1);
        i2c_stop();
        
        #100;
        if (sg_out !== 1'b1) $error("Stop condition failed");
    end
    endtask

    task test_invalid_data;
    begin
        $display("\nInvalid Data Test");
        i2c_start();
        sda = 1'bx;
        @(posedge clk);
        #10;
        if (invalid !== 2'b101) $error("Invalid data not detected");
        i2c_stop();
    end
    endtask

    
    task i2c_start;
    begin
        sda = 1;
        @(negedge scl);
        sda = 0;
        @(posedge scl);
    end
    endtask

    task i2c_stop;
    begin
        sda = 0;
        @(negedge scl);
        sda = 1;
        @(posedge scl);
    end
    endtask

    task i2c_send_bit;
    input bit_val;
    begin
        @(negedge scl);
        sda = bit_val;
        @(posedge scl);
    end
    endtask
endmodule
