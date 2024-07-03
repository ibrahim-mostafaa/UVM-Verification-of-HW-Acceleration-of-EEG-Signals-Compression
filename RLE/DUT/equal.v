module equal #(parameter width=8)(
input  [width-1:0] a,b, output  y);


assign y = (a===b)?1:0;


endmodule 