module not_gate #(parameter width =8 )(
input [width-1:0] a, 
output [width-1:0] y);

assign y=~a;

endmodule