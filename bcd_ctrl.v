`timescale 1ns / 1ps

module bcd_ctrl(
input[6:0] seg0, 
input[6:0] seg1, 
input[6:0] seg2, 
input[6:0] seg3,
input[1:0] refreshcounter, 
input clk,
output reg[6:0] op, 
input[3:0] sw,
input[6:0] sumseg0, sumseg1, sumseg2, sumseg3,
input[6:0] diffseg0, diffseg1, diffseg2, diffseg3,
input[6:0] multiplyseg0, multiplyseg1, multiplyseg2, multiplyseg3,
input[6:0] divseg0, divseg1, divseg2, divseg3,
input negsign,
input rstnum, 
output reg isOriginal
    );
    
reg[6:0] prevseg0, prevseg1, prevseg2, prevseg3;

always@(posedge clk) begin
    if (sw[0]) begin
        prevseg0 <= sumseg0;
        prevseg1 <= sumseg1;
        prevseg2 <= sumseg2;
        prevseg3 <= sumseg3; end
    else if (sw[1]) begin
        prevseg0 <= diffseg0;
        prevseg1 <= diffseg1;
        prevseg2 <= diffseg2;
        if (negsign == 1) 
            prevseg3 <= 7'b0111111;
        else if (negsign == 0)
            prevseg3 <= diffseg3;
    end
    else if (sw[2]) begin
      prevseg0 <= multiplyseg0;
      prevseg1 <= multiplyseg1;
      prevseg2 <= multiplyseg2;
      prevseg3 <= multiplyseg3;
    end
    else if (sw[3]) begin
       prevseg0 <= divseg0;
       prevseg1 <= divseg1;
       prevseg2 <= divseg2;
       prevseg3 <= divseg3;
   end
   else if (rstnum) begin
        prevseg0 <= seg0;
        prevseg1 <= seg1;
        prevseg2 <= seg2;
        prevseg3 <= seg3;
    end
    else
    begin
        prevseg0 <= prevseg0;
        prevseg1 <= prevseg1;
        prevseg2 <= prevseg2;
        prevseg3 <= prevseg3;
    end
end        

always@(refreshcounter) begin
    if (sw[0])
        begin
        case(refreshcounter)
            2'b00 : op = sumseg0;
            2'b01 : op = sumseg1;
            2'b10 : op = sumseg2;
            2'b11 : op = sumseg3;
        endcase
    isOriginal <= 0;
    end
    else
    if (sw[1]) begin
    isOriginal <= 0;
    if (negsign==0) begin
        case(refreshcounter)
               2'b00 : op = diffseg0;
               2'b01 : op = diffseg1;
               2'b10 : op = diffseg2;
               2'b11 : op = diffseg3;
        endcase end
        else
        begin
        case(refreshcounter)
               2'b00 : op = diffseg0;
               2'b01 : op = diffseg1;
               2'b10 : op = diffseg2;
               2'b11 : op = 7'b0111111;
         endcase
         end
         end
      else
      if (sw[2])
          begin
          isOriginal <= 0;
          case(refreshcounter)
                 2'b00 : op = multiplyseg0;
                 2'b01 : op = multiplyseg1;
                 2'b10 : op = multiplyseg2;
                 2'b11 : op = multiplyseg3;
           endcase
           end
     
      else  
           if (sw[3])
               begin 
               isOriginal <= 0;
               case(refreshcounter)
                          2'b00 : op = divseg0;
                          2'b01 : op = divseg1;
                          2'b10 : op = divseg2;
                          2'b11 : op = divseg3;
                endcase
                end
       
      else  if (rstnum)
               begin 
               isOriginal <= 1;
               case(refreshcounter)
                          2'b00 : op = seg0;
                          2'b01 : op = seg1;
                          2'b10 : op = seg2;
                          2'b11 : op = seg3;
                endcase
                end       
     else begin
        if (isOriginal == 0) begin
        case(refreshcounter)
                       2'b00 : op = prevseg0;
                       2'b01 : op = prevseg1;
                       2'b10 : op = prevseg2;
                       2'b11 : op = prevseg3;
         endcase end
         else if (isOriginal == 1) begin
            case(refreshcounter)
                       2'b00 : op = seg0;
                       2'b01 : op = seg1;
                       2'b10 : op = seg2;
                       2'b11 : op = seg3;
             endcase
         end
     end
end
endmodule
