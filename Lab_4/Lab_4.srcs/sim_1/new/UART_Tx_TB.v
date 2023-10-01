`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 12:44:50 PM
// Design Name: 
// Module Name: UART_Tx_TB
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


module MEM_TB();

reg EN;

wire [0:7] DAT;
wire  D_VAL;


MEM MEMORY(.EN(EN),.D_VAL(D_VAL),.data(DAT));

initial 
begin

EN <=1; #5; EN <= 0; #5; 
EN <= 1; #10; EN <= 0; #15
EN <= 1; #10; EN <= 0; #35
EN <= 1; #10; EN <= 0; 

end
endmodule
