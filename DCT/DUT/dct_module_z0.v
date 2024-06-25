// `include "Right_shifter.v"
// `include "xor_gate.v"
// `include "not_gate.v"
// `include "mux_2.v"
// `include "adder_extend_1bit.v"
// `include "adder.v"
// `include "flopr.v"
// `include "clk_div_8_counter.v"

module dct_module_z0 (
input signed [7:0]input0,input1,input2,input3,input4,input5,input6,input7,
input clk,rst_n,en,
input signed [16:0] ROM1_data, ROM2_data,
output [3:0] addr1, addr2,
output signed[18:0] OUTPUT);

wire signed [17:0] B;
wire signed [18:0] B_extended;
wire signed [18:0] A,D,Q;
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

assign addr1 = {x0[0],x1[0],x2[0],x3[0]};
assign addr2 = {x4[0],x5[0],x6[0],x7[0]};

adder_extend_1bit #(17) add1(ROM1_data,ROM2_data,1'b0,B);

assign B_extended = {B[17],B[17:0]}; 
adder #(19) add2(B_extended,A,1'b0,D);

flopr #(19) f1 (clk, rst_n, D,Q);
// assign A = {Q[18],Q[18:1]};
assign A = Q >>> 1;

clk_div_8_counter clk_inst (.clk(clk), .rst_n(rst_n), .clk_out(clk8)); 
flopr #(19)  f2 (.clk(clk8),.rst_n(rst_n),.d(Q),.q(OUTPUT));

endmodule  
