`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2023 02:38:18 PM
// Design Name: 
// Module Name: Rx_Tx_TB
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


module Rx_Tx_TB();

reg clk = 0, clkx2 = 0;
reg en = 1, SI = 1;

wire [0:7] PO;
wire DAT_RDY;
wire SO;


UART_Rx R___ (.clk(clkx2),.SI(SI),.PO(PO),.DAT_RDY(DAT_RDY));
UART_Tx_ T___ (.clk(clk), .DAT_RDY(DAT_RDY),.DATA(PO), .SO(SO));

always #2 clk = ~clk;
always #1 clkx2 = ~clkx2;
always #20 SI = ~SI;

always #140 
begin
//DAT_RDY = ~DAT_RDY;
end

endmodule
