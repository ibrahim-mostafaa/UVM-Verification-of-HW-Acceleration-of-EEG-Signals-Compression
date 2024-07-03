`include "adder.v"
`include "diff.v"
`include "flopr.v"

module dwt(
input wire clk,rst_n, 
input wire signed [7:0] input1,input2, 
output wire  signed [8:0] average, difference); 
 
wire signed [8:0] mid_avg,mid_diff; 
wire signed [8:0] shifted_average, shifted_difference;

adder #(8) a1 (input1,input2,mid_avg); 
diff #(8) d1 (input1,input2,mid_diff); 

assign shifted_average = mid_avg >>> 1;
assign shifted_difference = mid_diff >>> 1; 

flopr#(9) ff2 (.clk(clk), .rst_n(rst_n), .d(shifted_average), .q(average));
flopr#(9) ff3 (.clk(clk), .rst_n(rst_n), .d(shifted_difference), .q(difference));

endmodule 