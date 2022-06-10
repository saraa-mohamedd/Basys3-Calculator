`timescale 1ns / 1ps

module anodes_ctrl(
input[1:0] refreshcounter,
input clk,
output reg[3:0] anode_ctrl, 
input isOriginal,
output reg dot
    );

always@ (refreshcounter)
begin
    case(refreshcounter)
        2'b00: begin anode_ctrl = 4'b1110; dot<= 1'b1; end
        2'b01: begin anode_ctrl = 4'b1101; dot<= 1'b1; end
        2'b10: begin 
        anode_ctrl = 4'b1011; 
        if (isOriginal)
            dot <= 1'b0; //dot is output low
        else
             dot <= 1'b1; //dot is output low
        end
        2'b11: begin anode_ctrl = 4'b0111; dot<= 1'b1; end
    endcase
end
endmodule