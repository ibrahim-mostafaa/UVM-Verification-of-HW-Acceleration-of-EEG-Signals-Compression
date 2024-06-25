module clk_div_8_counter (
input clk,
input rst_n, 
output reg clk_out); 

reg [2:0] counter = 2'b00; // 3 bit counter, counts 8 counts
//4 counts high, 4 counts low 
// 8 cycles of ref_clk make 1 cycle of clk_out 

always@(posedge clk or negedge rst_n) begin 
if (!rst_n) counter <=0; 
else counter <= counter +1; 
end 

// output clk with 50% duty cycle 
always@(posedge clk or negedge rst_n) begin 
if (!rst_n) clk_out <=0; 
else if (counter < 4)   // clk_out is high at counter = 0,1,2,3  
clk_out <= 1'b1; 
else clk_out <= 1'b0;    // clk_out is low at counter = 4,5,6,7 
end 

endmodule 