`timescale 1ns/1ps

module linearizer_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [7:0] sensor_in;

    // Output
    wire [7:0] linear_out;

    // Instantiate DUT
    linearizer uut (
        .clk(clk),
        .rst(rst),
        .sensor_in(sensor_in),
        .linear_out(linear_out)
    );

    // Clock generation
    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;   // 10 ns clock period
    end

    // Test sequence
    initial
    begin

        // Initialize
        rst = 1;
        sensor_in = 8'd0;

        // Apply reset
        #15;
        rst = 0;

        // Test different input regions

        sensor_in = 8'd25;    // Region 1
        #10;

        sensor_in = 8'd50;    // Boundary
        #10;

        sensor_in = 8'd75;    // Region 2
        #10;

        sensor_in = 8'd100;   // Boundary
        #10;

        sensor_in = 8'd125;   // Region 3
        #10;

        sensor_in = 8'd150;   // Boundary
        #10;

        sensor_in = 8'd175;   // Region 4
        #10;

        sensor_in = 8'd200;   // Boundary
        #10;

        sensor_in = 8'd225;   // Region 5
        #10;

        sensor_in = 8'd255;   // Maximum value
        #10;

        // Finish simulation
        $finish;

    end

    // Monitor outputs
    initial
    begin
        $monitor("Time = %0t | rst = %b | sensor_in = %d | linear_out = %d",
                  $time, rst, sensor_in, linear_out);
    end

endmodule
