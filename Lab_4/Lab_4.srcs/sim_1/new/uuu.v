`timescale 1ns / 1ps

module uart_tx();
reg START_OK;

clk_div CLK_DIV (.clk(),.clk_o());

MEM MEM(.EN(),.D_VAL(),.data());

IDLE IDLE(.D_VAL(),.EN(),.IDLE_OK(),
          .clk(),.SERIAL_OUT(),.START_OK());

Tx_CTRL CTRL(.clk(), .IDLE_EN(), .IDLE_LVL(), 
             .START_EN(), .START_LVL(),.DATA_EN(),
             .DATA_LVL(),.END_EN(),.END_LVL(),.Tx_LVL());

START START(.clk(),.START_OK(),
            .LEVEL(),.DATA_OK());
            
DATA_ DATA_(.baud_clk(), .EN(), .CONT(),
            .data(),.SERIAL_OUT(), .END_OK());
            
END END(.D_VAL(), .clk(), .END_OK(),
        .SERIAL_OUT(), .CONT(), .IDLE_OK());
        
endmodule

module MEM (input wire EN, output reg D_VAL, reg [0:7] data);
reg [0:31] MSG = 32'h5A616964; //Zaid
always @ (posedge EN)
    begin
        if (MSG > 0)
            begin
                data <= MSG[0:7];
                MSG <= MSG << 8;
                D_VAL <= 1;
            end
        if (MSG == 0)
            begin
                data <= MSG[0:7];
                D_VAL <= 0; 
            end
    end
endmodule

module IDLE (input D_VAL, EN, IDLE_OK, clk, output reg SERIAL_OUT, reg START_OK); 

always @ (posedge clk) 
    begin
        if ((D_VAL == 1) && (EN || IDLE_OK))
            begin
                START_OK <= 1;
                SERIAL_OUT <= 0;
            end
        else 
            begin
                START_OK <=0;
                SERIAL_OUT <= 1;
            end
    end

endmodule

module START(input clk, START_OK, output reg LEVEL, reg DATA_OK);
always @ (posedge clk)
    begin
        if (START_OK) 
            begin
                LEVEL <= 0;
                DATA_OK <= 1;
            end
        else 
            begin
                DATA_OK <= 0;
                LEVEL <= 1;
            end
    end

endmodule

module DATA_(input baud_clk, EN, CONT, [0:7] data, output reg SERIAL_OUT, END_OK);

reg DAT_RDY = 1;
reg PAR_TGL = 0;
reg [0:7] PLL_BUFFR = 8'b0;
reg [0:3] Tx_Incr = 4'b0; // top value of 9... 8 bits & parity
reg [0:3] PRTY_BIT = 4'b0;

always @ (posedge baud_clk) 
begin
    if (DAT_RDY && (EN || CONT))
        begin
            PLL_BUFFR <= data;
            DAT_RDY <= 0;
            END_OK <= 0;
        end   
    if (Tx_Incr < 8)
        begin
            SERIAL_OUT <= PLL_BUFFR[0];
            Tx_Incr <= Tx_Incr + 1; 
            if (PLL_BUFFR[0]) PRTY_BIT <= PRTY_BIT + 1;
        end
    if (Tx_Incr >= 8)
        begin
            if (PAR_TGL == 1)
                begin 
                    if (Tx_Incr == 8) SERIAL_OUT <= PRTY_BIT[0];
                end
            else 
                begin
                    DAT_RDY <= 1;
                    Tx_Incr <= 4'b0;
                    PRTY_BIT <= 4'b0;
                    END_OK <= 1;
                end           
            end
        end

endmodule

module END(input D_VAL, clk, END_OK, output SERIAL_OUT, CONT, IDLE_OK );

always @ (posedge clk)
    begin
        
    end
endmodule

module Tx_CTRL (input clk, IDLE_EN, IDLE_LVL,START_EN, START_LVL, DATA_EN,DATA_LVL, END_EN, END_LVL, output reg Tx_LVL);

always @ (posedge clk) 
    begin
        if (IDLE_EN) Tx_LVL <= IDLE_LVL;
        else if (START_EN) Tx_LVL <= START_LVL;
        else if (DATA_EN) Tx_LVL <= DATA_LVL;
        else if (END_EN) Tx_LVL <= END_LVL;
        else Tx_LVL <= 0;
    end
endmodule

module clk_div #(parameter BAUDRATE = 28'd10417)(
clk, clk_o);

// why 10417? 100,000,000/9600 = 10416.666, roughly 10417

input clk;
output reg clk_o;
reg [27:0] accum = 28'b0;

always @ (posedge clk) 
    begin
        accum <= accum + 1;
        if (accum >= (BAUDRATE - 1)) accum <= 0; 
        clk_o <= (accum < (BAUDRATE/2)) ? 1:0; 
    end
endmodule