`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 03:10:09 AM
// Design Name: 
// Module Name: MEM
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
EN <= 1; #10; EN <= 0; #5
EN <= 1; #10; EN <= 0; #5
EN <= 1; #10; EN <= 0; #5
EN <= 1;
$finish;
end
endmodule

