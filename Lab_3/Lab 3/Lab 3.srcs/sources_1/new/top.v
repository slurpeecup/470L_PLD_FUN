`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2023 11:32:03 PM
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


module top(input clk ,[3:0] sw, output reg [3:0] an, reg [6:0] seg);
     
    wire clk_o;
    wire [6:0] seg_out;
    initial an <= 4'b1110; 
    
    clock_div c (.clk(clk), .clk_o(clk_o));
    seven_seg_bcd b (.clk_o(clk_o),.sw(sw),.seg_out(seg_out));
    
    always @ (posedge clk_o) 
        begin
            seg <= seg_out;
        end
    
endmodule

module seven_seg_bcd (input clk_o,[3:0] sw, output reg [6:0] seg_out);
reg [3:0] mux = 4'b1111;
reg flag = 1'b0;

always @ (posedge clk_o) 
    begin      
      if (flag == 0) 
      begin 
        mux <= 4'b1111; flag <= flag + 1; 
      end
        
      if (sw[0] == 1) mux <= 4'b1111; 
      else begin 
       mux <= mux - 1;                       // gfedcba
   
       if (mux == 4'b0000) 
         begin 
           seg_out <= 7'b1000000;
           mux <= 4'b1111; 
         end 
        
        else if (mux == 4'b0001)      seg_out = 7'b1111001 ;
        else if (mux == 4'b0010)      seg_out = 7'b0100100 ; 
        else if (mux == 4'b0011)      seg_out = 7'b0110000 ; 
        else if (mux == 4'b0100)      seg_out = 7'b0011001 ; 
        else if (mux == 4'b0101)      seg_out = 7'b0010010 ; 
        else if (mux == 4'b0110)      seg_out = 7'b0000010 ; 
        else if (mux == 4'b0111)      seg_out = 7'b1111000 ; 
        else if (mux == 4'b1000)      seg_out = 7'b0000000 ; 
        else if (mux == 4'b1001)      seg_out = 7'b0010000 ;
        // extra 4 fun 
        else if (mux == 4'b1010)      seg_out = 7'b0001000 ;
        else if (mux == 4'b1011)      seg_out = 7'b0000011 ;
        else if (mux == 4'b1100)      seg_out = 7'b1000110 ;
        else if (mux == 4'b1101)      seg_out = 7'b0100001 ;
        else if (mux == 4'b1110)      seg_out = 7'b0000110 ;
        else if (mux == 4'b1111)      seg_out = 7'b0001110 ;
        end
    end
endmodule

module clock_div #(parameter D = 28'b0101111101011110000100000000)(
clk, clk_o);

input clk;
output reg clk_o;
reg [27:0] accum = 28'b0;

always @ (posedge clk) 
    begin
        accum <= accum + 1;
        if (accum >= (D - 1)) accum <= 0; 
        clk_o <= (accum < (D/2)) ? 1:0; 
    end
endmodule