`timescale 1ns / 1ps

module main(

input EN, LD, UP, CLK, CLR,
input [3:0]DAT,
output reg CO,
reg [3:0]Q
);

always @ (posedge CLK) begin
    
    if (!CLR) begin $display("CLR\n"); Q = 0; end //clears on clear, takes precedent
    
    else if (LD && EN) begin $display("LDEN\n");Q <= DAT; end // input DATA
    
    else if (EN && UP)
        begin $display("ENUP\n");
            Q <= Q + 1;
        end
        
    else if (EN && !UP)
        begin $display("EN!UP\n");
            Q <= Q-1;
        end
end

always @ (negedge CLK) begin
    if (EN && UP)
        begin 
            if (Q == 9) CO <= 1;
                else CO <= 0;
        end
        
    if (EN && !UP)
        begin 
            if (Q == 0) CO <= 1;
                else CO <= 0;
        end
end

endmodule
