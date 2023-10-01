`timescale 1ns / 1ps

module UART_Tx(input clk, STOP, EN, DAT_RDY, [0:7] DATA, 
               parity_toggle, output reg SO, MEM_EN);

reg [0:7] PLL_BUFFR;
reg [0:4] iter;
reg [0:3] parity; 
reg [0:1] ST_CTRL = 0;
reg p_tg, MV_TO_END;

always @ (posedge clk)
    begin   
        if (ST_CTRL == 2'b00)
            begin
                SO = 1;
                if (STOP) ST_CTRL <= 2'b0;
                else if(EN && DAT_RDY) ST_CTRL <= 2'b01;        
                $display("IDLE");
            end        
        if (ST_CTRL == 2'b01)
            begin
                SO = 0;
                if (DAT_RDY == 1) MEM_EN = 1;
                ST_CTRL <= 2'b10;
                iter <= 0;
                p_tg <= parity_toggle;
                $display("START");
            end    
        if (ST_CTRL == 2'b10)
            begin
                MEM_EN <= 0;
                if (iter < (8 + p_tg))
                    begin
                       if (iter == 8) 
                           begin
                               SO = parity[0];
                           end
                       else if (iter < 8)
                            begin
                                if (iter == 0) 
                                    begin
                                        PLL_BUFFR = DATA; 
                                    end // rst at start prior to anything
 
                                        SO = PLL_BUFFR[7];
                                        $display("CURRENT_VAL %d", SO);
                                        parity <= parity + PLL_BUFFR[7];
                                        iter <= iter + 1;
                                        PLL_BUFFR <= PLL_BUFFR >> 1;
                                    if (iter == (7+p_tg)) 
                                        begin
                                            ST_CTRL <= 2'b11;
                                            parity <= 0;
                                            iter <= 0;
                                            if (STOP)MV_TO_END <=1; 
                                        end
                            end
                       end
            end    
        if (ST_CTRL == 2'b11)
            begin
            if (MV_TO_END) 
            begin
                ST_CTRL <= 2'b00;
                SO <= 1;
            end
            else if (DAT_RDY) ST_CTRL <= 2'b01;
                SO = 1;
                $display("END");
            end  
    end
endmodule


module MEM (input wire EN, meminit, output reg D_VAL, reg STOP, reg [0:7] data);
parameter CHARS = 120; 
reg [0:(CHARS-1)] MSG = 120'h5A61696420596173696E205E5F5F5E; //ADRIAN
always @ (posedge EN)
    begin
        if (MSG > 0)
            begin
                data <= MSG[0:7];
                MSG <= MSG << 8;
                D_VAL <= 1;
                STOP <= 0;
            end
        if (MSG [8:31] == 0)
            begin
                 STOP <= 1;
            end
        if (MSG==0)
            begin
                data <= 0;
                D_VAL <= 0; 
            end
    end
always @ (posedge meminit)
    begin
        D_VAL = D_VAL | 1'b1;
    end
endmodule
module clk_div #(parameter BAUDRATE = 28'd10417, SCALE = 1)(
clk, clk_o);
// why 10417? 100,000,000/9600 = 10416.666, roughly 10417
input clk;
output reg clk_o;
reg [27:0] accum = 28'b0;

always @ (posedge clk) 
    begin
        accum <= accum + 1;
        if (accum >= ((BAUDRATE - 1)/SCALE)) accum <= 0; 
        clk_o <= (accum < ((BAUDRATE/2)/SCALE)) ? 1:0; 
    end
endmodule