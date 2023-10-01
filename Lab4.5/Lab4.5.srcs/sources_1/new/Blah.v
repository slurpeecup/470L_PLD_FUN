`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 03:11:57 AM
// Design Name: 
// Module Name: Blah
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

module DATA_(input baud_clk, EN, CONT, [0:7] data, output reg SERIAL_OUT, END_OK);

reg PAR_TGL = 0;
reg COMMENCE = 0;


reg [0:7] PLL_BUFFR = 8'b0;
reg [0:3] Tx_Incr = 4'b0; // top value of 9... 8 bits & parity
reg [0:3] PRTY_BIT = 4'b0;


always @ (posedge baud_clk) 
begin
    $display("%d", data);
    if (EN || CONT)
        begin
            PLL_BUFFR[0:7] <= data[0:7];
            END_OK <= 0;
        end   
    if (Tx_Incr < 8)
        begin
            SERIAL_OUT <= PLL_BUFFR[0];
            Tx_Incr <= Tx_Incr + 1; 
            if (PLL_BUFFR[0]) PRTY_BIT <= PRTY_BIT + 1;
            PLL_BUFFR <= PLL_BUFFR << 1;
        end
    if (Tx_Incr >= 8)
        begin
            if (PAR_TGL == 1)
                begin 
                    if (Tx_Incr == 8) SERIAL_OUT <= PRTY_BIT[0];
                    $display("here2");
                end
            else 
                begin
                    Tx_Incr <= 4'b0;
                    PRTY_BIT <= 4'b0;
                    END_OK <= 1;
                    $display("here3");
                end           
            end
        end

endmodule

/**/