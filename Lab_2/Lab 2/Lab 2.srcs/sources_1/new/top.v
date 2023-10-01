`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2023 03:12:28 PM
// Design Name: 
// Module Name: top
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

module seven_seg_bcd (input clk, [3:0]sw, output reg [3:0] an, reg [6:0] seg);
always @ (posedge clk) 
    begin
        an <= 4'b1110;                     // gfedcba
        if      (sw == 4'b0000)      seg = 7'b1000000 ;
        else if (sw == 4'b0001)      seg = 7'b1111001 ;
        else if (sw == 4'b0010)      seg = 7'b0100100 ; 
        else if (sw == 4'b0011)      seg = 7'b0110000 ; 
        else if (sw == 4'b0100)      seg = 7'b0011001 ; 
        else if (sw == 4'b0101)      seg = 7'b0010010 ; 
        else if (sw == 4'b0110)      seg = 7'b0000010 ; 
        else if (sw == 4'b0111)      seg = 7'b1111000 ; 
        else if (sw == 4'b1000)      seg = 7'b0000000 ; 
        else if (sw == 4'b1001)      seg = 7'b0010000 ;
        // extra 4 fun 
        else if (sw == 4'b1010)      seg = 7'b0001000 ;
        else if (sw == 4'b1011)      seg = 7'b0000011 ;
        else if (sw == 4'b1100)      seg = 7'b1000110 ;
        else if (sw == 4'b1101)      seg = 7'b0100001 ;
        else if (sw == 4'b1110)      seg = 7'b0000110 ;
        else if (sw == 4'b1111)      seg = 7'b0001110 ;
    end
endmodule