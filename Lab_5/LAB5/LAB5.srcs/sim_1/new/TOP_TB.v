`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2023 02:18:47 PM
// Design Name: 
// Module Name: TOP_TB
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


module TOP_TB();

reg CLK = 0;
reg RsRx = 0;
reg SW = 1;

wire RsTx;

top txp (.RsRx(RsRx),.sw(SW),.CLK100MHZ(CLK),.RsTx(RsTx));

always #1 CLK = ~CLK;
always #10 RsRx = ~RsRx;

//initial 
//begin
always #20 SI = ~SI;
//$finish;
//end
endmodule
