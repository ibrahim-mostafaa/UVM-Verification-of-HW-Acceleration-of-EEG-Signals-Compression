// `include "Right_shifter.v"
// `include "xor_gate.v"
// `include "not_gate.v"
// `include "mux_2.v"
// `include "adder_extend_1bit.v"
// `include "adder.v"
// `include "flopr.v"
// `include "clk_div_8_counter.v"

module dct_module  (
input signed [7:0]input0,input1,input2,input3,input4,input5,input6,input7,
input clk,rst_n,en, 
input [15:0] ROM1_data, ROM2_data,  
output [2:0] addr1, addr2,
output signed[18:0] OUTPUT);

wire signed [15:0] var1_not,var2_not,B1,B2;
wire signed [16:0] B;
wire signed [18:0] B_extended;
wire signed [18:0] A,D,Q;
wire n1,n2,n3,n4,n5,n6;
wire signed s1,s2;
wire clk8;


wire signed [7:0] x0,x1,x2,x3,x4,x5,x6,x7;

Right_shifter r1 (clk,rst_n,en,input0,x0);
Right_shifter r2 (clk,rst_n,en,input1,x1);
Right_shifter r3 (clk,rst_n,en,input2,x2);
Right_shifter r4 (clk,rst_n,en,input3,x3);
Right_shifter r5 (clk,rst_n,en,input4,x4);
Right_shifter r6 (clk,rst_n,en,input5,x5);
Right_shifter r7 (clk,rst_n,en,input6,x6);
Right_shifter r8 (clk,rst_n,en,input7,x7);


xor_gate  xor1(x0[0],x1[0],n1);
xor_gate  xor2(x0[0],x2[0],n2);
xor_gate  xor3(x0[0],x3[0],n3);
assign addr1 = {n1,n2,n3}; 

xor_gate  xor4(x4[0],x5[0],n4);
xor_gate  xor5(x4[0],x6[0],n5);
xor_gate  xor6(x4[0],x7[0],n6);
assign addr2 = {n4,n5,n6}; 

assign s1 = x0[0];
assign s2 = x4[0];

not_gate #(16)  not1(ROM1_data,var1_not);
mux_2 #(16)  mux1 (ROM1_data,var1_not,s1, B1);

not_gate #(16) not2(ROM2_data,var2_not);
mux_2 #(16) mux2 (ROM2_data,var2_not,s2, B2);

adder_extend_1bit #(16) add1(B1,B2,s1,B);

assign B_extended = {B[16],B[16],B[16:0]}; 
adder #(19) add2(B_extended,A,s2,D);

flopr #(19) f1 (clk, rst_n, D,Q);
// assign A = {Q[17],Q[17:1]};
assign A = Q >>> 1;

clk_div_8_counter clk_inst (.clk(clk), .rst_n(rst_n), .clk_out(clk8)); 
flopr #(19)  f2 (.clk(clk8),.rst_n(rst_n),.d(Q),.q(OUTPUT));

endmodule  
