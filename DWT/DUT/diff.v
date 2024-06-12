
module diff #(parameter width = 8) ( 
input wire signed [width-1:0] a,b, 
output wire signed [width :0] y
); 

assign y = a - b;

endmodule