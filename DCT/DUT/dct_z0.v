// `include "dct_module_z0.v"
// `include "ROM1_Z0.v"
// `include "ROM2_Z0.v"

module dct_z0 (
input signed [7:0]input0,input1,input2,input3,input4,input5,input6,input7,
input clk,rst_n,en, 
input cs, 
output signed[18:0] OUTPUT_Z0);

//Internal signals between dct_module and ROMs (addr & data)
wire [3:0] addr1, addr2;
wire signed [16:0] ROM1_data, ROM2_data; 
 
dct_module_z0 inst_z0 (
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

    .OUTPUT(OUTPUT_Z0)
    );

    ROM1_Z0 inst_rom1 (.addr(addr1),.data(ROM1_data),.cs(cs),.rst_n(rst_n),.clk(clk));

    ROM2_Z0 inst_rom2 (.addr(addr2),.data(ROM2_data),.cs(cs),.rst_n(rst_n),.clk(clk));


endmodule  
