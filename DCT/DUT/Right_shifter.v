module Right_shifter #(parameter width = 8) (
input clk, rst_n,en,
input [width-1:0]din,
output reg [width-1:0]q);

always @(posedge clk or negedge rst_n)
if (!rst_n) q <= 0;
else if (en) q <= din;
else q <= {1'b0,q[width-1:1]};

endmodule
