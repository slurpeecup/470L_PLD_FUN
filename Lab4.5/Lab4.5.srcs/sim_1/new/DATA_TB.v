`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 04:44:29 PM
// Design Name: 
// Module Name: DATA_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//DATA_(input baud_clk, EN, CONT, [0:7] data, output reg SERIAL_OUT, END_OK);

module DATA_TB();

reg baud_clk = 1;
reg EN = 0;
reg CONT = 1;
reg [0:7] data = 8'h5A;
wire SERIAL_OUT;
wire END_OK;

DATA_ DATA_1 (.baud_clk(baud_clk),.EN(EN),.CONT(CONT),.data(data),.SERIAL_OUT(SERIAL_OUT),.END_OK(END_OK));

always #5 baud_clk <= ~baud_clk;
initial begin
#10; EN = 1; #200;
$finish;
end
endmodule
