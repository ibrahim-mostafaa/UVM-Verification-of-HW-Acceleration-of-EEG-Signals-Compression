// `include "dct_module.v"
// `include "ROM1_Z3.v"
// `include "ROM2_Z3.v"

module dct_z3  (
input signed [7:0]input0,input1,input2,input3,input4,input5,input6,input7,
input clk,rst_n,en, 
input cs, 
output signed[18:0] OUTPUT_Z3);

//Internal signals between dct_module and ROMs (addr & data)
wire [2:0] addr1, addr2;
wire signed [15:0] ROM1_data, ROM2_data; 
 
dct_module inst_z3 (
   .clk(clk), 
    .rst_n(rst_n), 
    .en(en),

    .input0(input0),  
    .input1(input1),  
    .input2(input2),  
    .input3(input3),  

    .input4(input4),  
    .input5(input5),  
    .input6(input6),  
    .input7(input7),  
    
    .addr1(addr1),
    .addr2(addr2),

    .ROM1_data(ROM1_data),
    .ROM2_data(ROM2_data),

    .OUTPUT(OUTPUT_Z3)
    );

    ROM1_Z3 inst_rom1 (.clk(clk),.rst_n(rst_n),.cs(cs),.addr(addr1),.data(ROM1_data));

    ROM2_Z3 inst_rom2 (.clk(clk),.rst_n(rst_n),.cs(cs),.addr(addr2),.data(ROM2_data));


endmodule  
