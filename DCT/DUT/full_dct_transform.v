`include "dct_top.v"
`include "transform.v"

module full_dct_transform(
input signed [7:0]input0,input1,input2,input3,input4,input5,input6,input7,
input clk,rst_n,en,cs, 
output signed [12:0] integer_Z0, integer_Z1, integer_Z2, integer_Z3, integer_Z4,integer_Z5, integer_Z6, integer_Z7
);

wire signed [18:0] fraction_z0, fraction_z1, fraction_z2,fraction_z3, fraction_z4,fraction_z5, fraction_z6, fraction_z7;

//dct_top
dct_top top1(
.input0(input0),
.input1(input1),
.input2(input2),
.input3(input3),
.input4(input4),
.input5(input5),
.input6(input6),
.input7(input7),

.clk(clk),
.rst_n(rst_n),
.en(en),
.cs(cs),

.OUTPUT_Z0(fraction_z0),
.OUTPUT_Z1(fraction_z1),
.OUTPUT_Z2(fraction_z2),
.OUTPUT_Z3(fraction_z3),
.OUTPUT_Z4(fraction_z4),
.OUTPUT_Z5(fraction_z5),
.OUTPUT_Z6(fraction_z6),
.OUTPUT_Z7(fraction_z7)
); 

//transform
transform t1 ( 
.fraction_z0(fraction_z0),
.fraction_z1(fraction_z1),
.fraction_z2(fraction_z2),
.fraction_z3(fraction_z3),
.fraction_z4(fraction_z4),
.fraction_z5(fraction_z5),
.fraction_z6(fraction_z6),
.fraction_z7(fraction_z7),

.integer_Z0(integer_Z0),
.integer_Z1(integer_Z1),
.integer_Z2(integer_Z2),
.integer_Z3(integer_Z3),
.integer_Z4(integer_Z4),
.integer_Z5(integer_Z5),
.integer_Z6(integer_Z6),
.integer_Z7(integer_Z7)
);

endmodule


