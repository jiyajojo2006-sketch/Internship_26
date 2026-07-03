`timescale 1 ns/10 ps

module linearizer_main(

    input          clk_pad,
    input          rst_pad,
    input  [7:0]   sensor_in_pad,
    output [7:0]   linear_out_pad

);

wire        clk;
wire        rst;
wire [7:0]  sensor_in;
reg  [7:0]  linear_out;

wire linearizer_clk;

pc3c01 pc3c01_1   (.CCLK(linearizer_clk), .CP(clk));
pc3d01 pc3d01_1   (.PAD(clk_pad), .CIN(linearizer_clk));
pc3d01 pc3d01_2   (.PAD(rst_pad), .CIN(rst));
pc3d01 pc3d01_3   (.PAD(sensor_in_pad[0]), .CIN(sensor_in[0]));
pc3d01 pc3d01_4   (.PAD(sensor_in_pad[1]), .CIN(sensor_in[1]));
pc3d01 pc3d01_5   (.PAD(sensor_in_pad[2]), .CIN(sensor_in[2]));
pc3d01 pc3d01_6   (.PAD(sensor_in_pad[3]), .CIN(sensor_in[3]));
pc3d01 pc3d01_7   (.PAD(sensor_in_pad[4]), .CIN(sensor_in[4]));
pc3d01 pc3d01_8   (.PAD(sensor_in_pad[5]), .CIN(sensor_in[5]));
pc3d01 pc3d01_9   (.PAD(sensor_in_pad[6]), .CIN(sensor_in[6]));
pc3d01 pc3d01_10  (.PAD(sensor_in_pad[7]), .CIN(sensor_in[7]));

pc3o05 pc3o05_1   (.I(linear_out[0]), .PAD(linear_out_pad[0]));
pc3o05 pc3o05_2   (.I(linear_out[1]), .PAD(linear_out_pad[1]));
pc3o05 pc3o05_3   (.I(linear_out[2]), .PAD(linear_out_pad[2]));
pc3o05 pc3o05_4   (.I(linear_out[3]), .PAD(linear_out_pad[3]));
pc3o05 pc3o05_5   (.I(linear_out[4]), .PAD(linear_out_pad[4]));
pc3o05 pc3o05_6   (.I(linear_out[5]), .PAD(linear_out_pad[5]));
pc3o05 pc3o05_7   (.I(linear_out[6]), .PAD(linear_out_pad[6]));
pc3o05 pc3o05_8   (.I(linear_out[7]), .PAD(linear_out_pad[7]));

always @(posedge clk or posedge rst)
begin
    if(rst)
        linear_out <= 8'd0;

    else
    begin

        if(sensor_in <= 8'd50)
            linear_out <= sensor_in >> 1;

        else if(sensor_in <= 8'd100)
            linear_out <= (((sensor_in - 8'd50) >> 1)
                         - ((sensor_in - 8'd50) >> 4))
                         + 8'd20;

        else if(sensor_in <= 8'd150)
            linear_out <= (((sensor_in - 8'd100) >> 1)
                         - ((sensor_in - 8'd100) >> 4))
                         + 8'd40;

        else if(sensor_in <= 8'd200)
            linear_out <= (((sensor_in - 8'd150) >> 1)
                         - ((sensor_in - 8'd150) >> 4))
                         + 8'd60;

        else
            linear_out <= (((sensor_in - 8'd200) >> 1)
                         - ((sensor_in - 8'd200) >> 4))
                         + 8'd80;

    end
end

endmodule
