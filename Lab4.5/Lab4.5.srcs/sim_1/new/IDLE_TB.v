`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 01:40:36 PM
// Design Name: 
// Module Name: IDLE_TB
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

//input D_VAL, EN, IDLE_OK, clk, output reg SERIAL_OUT, reg START_OK
module IDLE_TB();

reg EN = 1'b1;
reg D_VAL = 1'b1;
reg IDLE_OK = 1'b1;
reg clk = 1'b1;

wire SERIAL_OUT;
wire  START_OK;

always #5 clk = ~clk;

IDLE IDLE_1(.D_VAL(D_VAL),.EN(EN),.IDLE_OK(IDLE_OK), .clk(clk),.SERIAL_OUT(SERIAL_OUT),.START_OK(START_OK));

initial 
begin

D_VAL = 1'b1; clk = 1'b1;

EN <=1; #5; EN <= 0; #5; D_VAL <= 0; #10; 
D_VAL <= 1; #10;
EN <= 1; #10; D_VAL <= 0; #10;
D_VAL <= 1; #10; IDLE_OK <= 0; #10;
IDLE_OK <= 1; #10; EN <= 0; #10;
EN <= 1;
$finish;
end 
endmodule


