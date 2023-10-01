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
reg SI;

wire [0:7] PO;

UART_Rx Rx_ (.clk(clk),.SI(SI),.PO(PO));

always #5 
begin
clk = ~clk; //$display("clock\n");
end

initial
begin 

SI = 1; #20; SI = 0; #10; SI = 1; #10; SI = 0;
        #10; SI = 1; #10; SI = 0;
        #10; SI = 1; #10; SI = 0;
        #10; SI = 1; #10; SI = 1;
        #200;

$finish;
end
endmodule
