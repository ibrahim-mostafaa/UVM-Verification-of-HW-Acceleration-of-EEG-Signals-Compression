
module flopr#(parameter width =8)(
input wire clk, rst_n, 
input wire signed [width-1:0] d, 
output reg signed [width-1:0] q 
);

always @(posedge clk or negedge rst_n)
if (!rst_n) q <= 0;
else q <= d;

endmodule 