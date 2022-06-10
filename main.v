`timescale 1ns / 1ps

module main(
input clk,
input rst, 
input[3:0] buttons, 
output[6:0] op,
output[3:0] anode, 
input r,
input [3:0] sw,
output dot
///input rstnum
);

wire isOriginal;
wire newclk;
wire[1:0] rfshcounter;

wire[6:0] seg0;
wire[6:0] seg1;
wire[6:0] seg2;
wire[6:0] seg3;

wire[3:0] dig0;
wire[3:0] dig1;
wire[3:0] dig2;
wire[3:0] dig3;

wire[9:0] sum;
wire[13:0] subtract;
wire[13:0] multiply;
wire[6:0] divide;

wire[6:0] sumseg0;
wire[6:0] sumseg1;
wire[6:0] sumseg2;
wire[6:0] sumseg3;

wire negsign;
wire[6:0] subtractseg0;
wire[6:0] subtractseg1;
wire[6:0] subtractseg2;
wire[6:0] subtractseg3;

wire[6:0] multiplyseg0;
wire[6:0] multiplyseg1;
wire[6:0] multiplyseg2;
wire[6:0] multiplyseg3;

wire[6:0] divseg0;
wire[6:0] divseg1;
wire[6:0] divseg2;
wire[6:0] divseg3;

clock c(.clock(clk), .reset(r), .clock_out(newclk));
refreshcounter count(.rfsh_clk(newclk), .rfshcounter(rfshcounter));
anodes_ctrl hg(.refreshcounter(rfshcounter), .clk(newclk) ,.anode_ctrl(anode), .isOriginal(isOriginal), .dot(dot));

seven_seg_ctrl d_0(.button(buttons[0]), .reset(rst), .clk_in(rfshcounter), .seven_seg(seg0), .digit(dig0));
seven_seg_ctrl d_1(.button(buttons[1]), .reset(rst), .clk_in(rfshcounter), .seven_seg(seg1), .digit(dig1));
seven_seg_ctrl d_2(.button(buttons[2]), .reset(rst), .clk_in(rfshcounter), .seven_seg(seg2), .digit(dig2));
seven_seg_ctrl d_3(.button(buttons[3]), .reset(rst), .clk_in(rfshcounter), .seven_seg(seg3), .digit(dig3));


bcd_ctrl test1(.seg0(seg0), .seg1(seg1), .seg2(seg2), .seg3(seg3), .refreshcounter(rfshcounter), .clk(newclk), .op(op), .sw(sw), .sumseg0(sumseg0), .sumseg1(sumseg1), .sumseg2(sumseg2),
               .sumseg3(sumseg3), .diffseg0(subtractseg0), .diffseg1(subtractseg1), .diffseg2(subtractseg2), .diffseg3(subtractseg3), .multiplyseg0(multiplyseg0), .multiplyseg1(multiplyseg1), 
               .multiplyseg2(multiplyseg2), .multiplyseg3(multiplyseg3), .divseg0(divseg0), .divseg1(divseg1), .divseg2(divseg2), .divseg3(divseg3),.negsign(negsign), .rstnum(rst), 
               .isOriginal(isOriginal));
operation_ctrl res( .dig0(dig0), .dig1(dig1), .dig2(dig2), .dig3(dig3), .clk_in(newclk), .sumresult(sum), .subtract(subtract), .multiply(multiply), .divide(divide), .negsign(negsign));


seven_seg_decoder s0(.digit(((sum%1000)%100)%10), .seven_seg(sumseg0), .clk_in(newclk));
seven_seg_decoder s1(.digit(((sum%1000)%100)/10), .seven_seg(sumseg1), .clk_in(newclk));
seven_seg_decoder s2(.digit((sum%1000)/100), .seven_seg(sumseg2), .clk_in(newclk));
seven_seg_decoder s3(.digit(0), .seven_seg(sumseg3), .clk_in(newclk));


seven_seg_decoder d0(.digit(((subtract%1000)%100)%10), .seven_seg(subtractseg0), .clk_in(newclk));
seven_seg_decoder d1(.digit(((subtract%1000)%100)/10), .seven_seg(subtractseg1), .clk_in(newclk));
seven_seg_decoder d2(.digit((subtract%1000)/100), .seven_seg(subtractseg2), .clk_in(newclk));
seven_seg_decoder d3(.digit(0), .seven_seg(subtractseg3), .clk_in(newclk));


seven_seg_decoder m0(.digit(((multiply%1000)%100)%10), .seven_seg(multiplyseg0), .clk_in(newclk));
seven_seg_decoder m1(.digit(((multiply%1000)%100)/10), .seven_seg(multiplyseg1), .clk_in(newclk));
seven_seg_decoder m2(.digit((multiply%1000)/100), .seven_seg(multiplyseg2), .clk_in(newclk));
seven_seg_decoder m3(.digit(multiply/1000), .seven_seg(multiplyseg3), .clk_in(newclk));

seven_seg_decoder div0(.digit(((divide%1000)%100)%10), .seven_seg(divseg0), .clk_in(newclk));
seven_seg_decoder div1(.digit(((divide%1000)%100)/10), .seven_seg(divseg1), .clk_in(newclk));
seven_seg_decoder div2(.digit((divide%1000)/100), .seven_seg(divseg2), .clk_in(newclk));
seven_seg_decoder div3(.digit(0), .seven_seg(divseg3), .clk_in(newclk));

endmodule