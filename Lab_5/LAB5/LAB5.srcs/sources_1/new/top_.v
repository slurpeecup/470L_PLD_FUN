`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 06:05:32 PM
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


module top();
//RS232 SIPO -> PISO
clk_div c1(.clk(),.clk_o());
clk_div #(SCALE = 2) c2 (.clk(),.clk_o());

UART_Tx(.clk(),.STOP(),.EN(),.DAT_RDY(),
        .DATA(),.parity_toggle(),.SO(),
                            .MEM_EN());
                            
UART_Rx(.clk(),.SI(),.PO());

endmodule


module UART_Rx(input clk, SI, output reg [0:7] PO);
reg [0:7] Rx_MGMT = 8'b00; // 00 idle, 01 dat, 11 end; //[2:5] iterator
reg [0:7] Rx_BFR = 0;
always @ (posedge clk)
begin
     if (Rx_MGMT[0:1] == 2'b00)
         begin
         Rx_MGMT[2:5] <= 4'b0;
             if (SI == 0)
                 begin;
                     Rx_MGMT[0:1] = 2'b01;
                 end            
             else
                 begin 
                     Rx_MGMT[0:1] = 2'b00;
                 end
         end
         
    if (Rx_MGMT[0:1] == 2'b01)
        begin
             if (Rx_MGMT[2:5] <= 7)
                  begin
                     Rx_BFR[Rx_MGMT[2:5]] <= SI;
                     Rx_MGMT[2:5] = Rx_MGMT[2:5] + 1; 
                  end           
              else if (Rx_MGMT[2:5]>=8)
                  begin
                    Rx_MGMT[0:1] <= 2'b00;
                    PO <= Rx_BFR;            
                  end            
        end
end  
endmodule