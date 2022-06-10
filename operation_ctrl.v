`timescale 1ns / 1ps

module operation_ctrl(input [3:0]dig0, input [3:0]dig1, input[3:0] dig2, input[3:0] dig3, input clk_in, output reg [9:0] sumresult,reg [13:0] subtract,
reg [13:0] multiply, reg [6:0] divide, output reg negsign = 0);
    
wire [6:0] num1= dig3*10 + dig2;
wire [6:0] num2= dig1*10+ dig0;
 

always@(posedge clk_in)
begin
sumresult <= num1+num2;
begin
if (num1>=num2)
begin
    subtract <= num1-num2;
    negsign<=0;
end
else 
begin
    subtract<=num2-num1;
    negsign<=1;
end 
end

multiply <= num1* num2;

begin
     if (num2==0 | num1==0)
           divide=0;
     else if (num1>num2)
           divide = num1/num2;
      else if (num1 == num2)
            divide = 1;
      else
            divide = 0;
end
end

endmodule
