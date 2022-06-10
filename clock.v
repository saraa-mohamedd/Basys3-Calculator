`timescale 1ns / 1ps

module clock #(parameter n = 5000)(input clock, reset, output reg clock_out = 0);
reg [31:0] count = 0; // Big enough to hold the maximum possible value

// Increment count
always @ (posedge clock, posedge reset) begin // Asynchronous Reset
    if (reset == 1'b1)
        count <= 32'b0;
    else if (count == n-1)
        count <= 32'b0;
    else
        begin count <= count + 1; end
end

// Handle the output clock
always @ (posedge clock, posedge reset) begin // Asynchronous Reset
    if (reset == 1'b1)
        clock_out <= 1'b0;
    else if (count == n-1)
        clock_out <= ~clock_out;
    else
        clock_out <= clock_out;
end

endmodule