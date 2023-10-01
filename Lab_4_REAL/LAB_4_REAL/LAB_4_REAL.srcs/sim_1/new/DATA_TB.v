`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 05:57:16 AM
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


module UART_Tx_TB();
reg CLK, EN, PTY, D_VAL, meminit;
reg [0:7] DATA;
wire SO, d_val, mem_en, STOP;
wire [0:7] data;

UART_Tx Tx_(.clk(CLK),.STOP(STOP),.EN(EN),.DAT_RDY(d_val),.DATA(data),.parity_toggle(PTY),.SO(SO),.MEM_EN(mem_en));
MEM MEM_(.EN(mem_en),.meminit(meminit),.D_VAL(d_val),.STOP(STOP),.data(data));
always #5 begin CLK = !CLK; end

initial begin
DATA = 8'h5a; D_VAL = 1; meminit <=1; 
CLK <= 1; PTY <= 0;
#10 EN <= 1; #1400; 
$finish;
end
endmodule

