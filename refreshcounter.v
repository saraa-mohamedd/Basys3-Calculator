`timescale 1ns / 1ps

module refreshcounter(
input rfsh_clk, 
output reg[1:0] rfshcounter
    );
    
always@(posedge rfsh_clk)
     rfshcounter <= rfshcounter + 1;
endmodule
