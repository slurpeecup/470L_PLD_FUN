`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 10:08:11 PM
// Design Name: 
// Module Name: Rx_TB
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


module Rx_TB();

reg clk = 1'b1;
reg SI = 0;
wire DAT_RDY;
wire [0:7] PO;

UART_Rx Rx_ (.clk(clk),.SI(SI),.PO(PO),.DAT_RDY(DAT_RDY));

always #5 
begin
clk = ~clk; //$display("clock\n");
end

always #20 SI = ~SI;


endmodule
