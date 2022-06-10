`timescale 1ns / 1ps

module seven_seg_ctrl(
input button, 
input reset, 
input clk_in, 
output reg[6:0] seven_seg,
output reg[3:0] digit
    );
    
reg push_f;
reg push_sync;
reg push_sync_f;
wire push_edge;

always@(posedge clk_in) begin
    push_f <= button;
    push_sync <= push_f;    
end

always @(posedge clk_in) begin
if (reset) begin
    push_sync_f <= 1'b0;
end else begin
    push_sync_f <= push_sync;
    end
end

assign push_edge = push_sync & ~push_sync_f;

always@(posedge clk_in) begin
if (reset)
    digit <= digit;
if (push_edge) begin
    if (digit != 9) begin
        digit <= digit + 1; end
    else begin
        digit <= 0; end
    end
end

always @ (posedge clk_in)
    case(digit)
        4'b0000 : seven_seg = 7'b1000000;
        4'b0001 : seven_seg = 7'b1111001;
        4'b0010 : seven_seg = 7'b0100100;
        4'b0011 : seven_seg = 7'b0110000;
        4'b0100 : seven_seg = 7'b0011001;
        4'b0101 : seven_seg = 7'b0010010;
        4'b0110 : seven_seg = 7'b0000010;
        4'b0111 : seven_seg = 7'b1111000;
        4'b1000 : seven_seg = 7'b0000000;
        4'b1001 : seven_seg = 7'b0010000;
        default : seven_seg = 7'b1111111;
    endcase
    
endmodule
