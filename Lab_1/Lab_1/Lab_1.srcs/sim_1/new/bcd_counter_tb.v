`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2023 01:25:01 PM
// Design Name: 
// Module Name: bcd_counter_tb
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

module main_tb();
    reg CLK = 1'b0;
    reg EN, LD, UP, CLR = 1'b0;
    reg [3:0] IN;
    wire CO;
    wire [3:0] OUT;
  
    main ctr(.EN(EN), .LD(LD), .UP(UP), .CLK(CLK), .CLR(CLR), .DAT(IN), .Q(OUT), .CO(CO));
    always #5 CLK = ~CLK;
    
    initial begin
                IN = 4'd7;  
                #10; CLR = 1'b1; EN = 1'b1; LD = 1'b1;
                #10; UP = 1'b1; LD = 1'b0;
                #40; UP = 1'b0;
                #15; CLR = 1'b0;
                #10; $finish; 
            end
    
endmodule