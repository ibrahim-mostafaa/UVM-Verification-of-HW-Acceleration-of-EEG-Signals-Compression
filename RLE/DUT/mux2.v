module mux2 #(parameter width =8 )(
input  [width-1:0] d0,d1, 
input  sel, 
output  [width-1:0] y);

assign y=sel?d1:d0;

endmodule