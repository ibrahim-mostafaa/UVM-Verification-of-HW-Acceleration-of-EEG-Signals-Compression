`include "flopr.v"
`include "equal.v"
`include "flopenr.v"
`include "mux2.v"

module rle(
    
input clk, rst_n,
input signed [8:0] Input, 
output signed [8:0] Output, 
output [7:0] Counter); // 256 Counts

wire signed [8:0]n;
wire sel,en;
wire [7:0] counter1,counter2;
wire signed [8:0] output1,output2;

flopr #(9) ff4(.clk(clk),.rst_n(rst_n),.d(Input),.q(n));
equal #(9) eq1 (.a(Input), .b(n), .y(sel));

//to enable Output, Counter outputs for old repeated input, when a new input in 
assign en = ~sel;

//Counter Logic
mux2#(8) m1(.d0(8'b0000_0001), .d1(counter2 +1'b1), .sel(sel),.y(counter1));
flopr#(8) ff5(.clk(clk),.rst_n(rst_n),.d(counter1),.q(counter2));
flopenr #(8) ff6(.clk(clk),.rst_n(rst_n),.en(en),.d(counter2),.q(Counter));

//Output logic
mux2#(9) m2(.d0(Input), .d1(output2), .sel(sel),.y(output1));
flopr#(9) ff7(.clk(clk),.rst_n(rst_n),.d(output1),.q(output2));
flopenr #(9) ff8(.clk(clk),.rst_n(rst_n),.en(en),.d(output2),.q(Output));

endmodule 