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


module top(input RsTx, [0:7] sw, wire CLK100MHZ, output RsRx);
//RS232 SIPO -> PISO
defparam c2.SCALE = 2;


wire CLKBAUD, CLKBAUD_d2;
wire DAT_RDY;
wire [0:7] PO; //
wire SO;
clk_div c1(.clk(CLK100MHZ),.clk_o(CLKBAUD));
clk_div c2(.clk(CLK100MHZ),.clk_o(CLKBAUD_d2));

UART_Rx rx (.clk(CLKBAUD),.SI(RsTx),.PO(PO),.DAT_RDY(DAT_RDY)); // should wait 2 clocks but need to modify Rx

UART_Tx_ tx (.clk(CLKBAUD),.EN(sw[0]),.DAT_RDY(DAT_RDT),.DATA(PO),.SO(SO));
                            
assign RsRx = SO;

endmodule


module UART_Rx(input clk, SI, output reg [0:7] PO, reg DAT_RDY);
reg [0:7] Rx_MGMT = 8'b00; // 00 idle, 01 dat, 11 end; //[2:5] iterator
reg [0:7] Rx_BFR = 0;
reg SAMP = 0;
always @ (posedge clk)
begin
SAMP = ~SAMP;
     if (Rx_MGMT[0:1] == 2'b00)
         begin
         Rx_MGMT[2:5] <= 4'b0;
             if (SI == 0)
                 begin;
                 DAT_RDY <=0;
                     Rx_MGMT[0:1] = 2'b01;
                 end            
             else
                 begin 
                     DAT_RDY <= 1;
                     Rx_MGMT[0:1] = 2'b00;
                 end
         end
         
    if (Rx_MGMT[0:1] == 2'b01)
        begin
             if (Rx_MGMT[2:5] <= 7)
                  begin
                     Rx_BFR[Rx_MGMT[2:5]] <= SI;               //Does this twice, moves on at 2x clock.
                     if(SAMP)Rx_MGMT[2:5] = Rx_MGMT[2:5] + 1; 
                  end           
              else if (Rx_MGMT[2:5]>=8)
                  begin
                    Rx_MGMT[0:1] <= 2'b00; // transitions state in one cycle
                    PO <= Rx_BFR;            
                  end            
        end
end  
endmodule

module UART_Tx_(input clk, EN, DAT_RDY,[0:7] DATA, output reg SO);

reg [0:7] PLL_BUFFR;
reg [0:4] iter;
reg [0:1] ST_CTRL = 0;
reg MV_TO_END;

always @ (posedge clk)
    begin   
        if (ST_CTRL == 2'b00)
            begin
                SO = 1; //  idle unless enabled & empty
                if(EN && ~DAT_RDY) ST_CTRL <= 2'b01;        
                $display("IDLE\n"); 
            end        
        if (ST_CTRL == 2'b01)
            begin
                SO = 0;
                ST_CTRL <= 2'b10; // res
                iter <= 0;
                $display("START\n");
            end    
       
        if (ST_CTRL == 2'b10)
            begin
                  if (iter < 8)
                      begin
                         if (iter == 0) 
                             begin
                                 PLL_BUFFR = DATA; 
                             end // rst at start prior to anything
 
                              SO = PLL_BUFFR[7];
                              iter <= iter + 1;
                              PLL_BUFFR <= PLL_BUFFR >> 1;
                         if (iter == (7)) 
                                        begin
                                            ST_CTRL <= 2'b11;
                                            iter <= 0;
                                        end
                              end
            end    
        if (ST_CTRL == 2'b11)
            begin
                if (~DAT_RDY) 
                 begin
                   ST_CTRL <= 2'b01;
                   SO = 1;
                 end
                else 
                 begin
                    ST_CTRL <= 2'b00;
                    SO <= 1; 
                 end

            end  
    end
endmodule