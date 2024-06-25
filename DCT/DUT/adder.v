module adder #(parameter width = 4) (
input signed [width-1:0]a,b,
input cin, 
output signed [width-1:0]sum);

assign sum = a + b + $signed({1'b0,cin}) ; 

endmodule 

