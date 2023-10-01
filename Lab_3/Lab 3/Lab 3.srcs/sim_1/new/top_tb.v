`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2023 12:04:04 AM
// Design Name: 
// Module Name: top_tb
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

module top_tb;

reg clk;
reg [3:0] sw = 4'b0000;

wire [3:0] an;
wire [6:0] seg;

top tu (.clk(clk),.sw(sw),.an(an),.seg(seg));

initial 
begin 
    clk = 1'b0;
    forever #5 clk = ~clk; 
end
endmodule
