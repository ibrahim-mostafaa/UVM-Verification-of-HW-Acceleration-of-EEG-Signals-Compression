//Testbench
`include "uvm_pkg.sv"
`include "pack1.sv"
`include "Interface.sv"
`include "full_dct_transform.v"

module TB_Top;
import uvm_pkg::*;
import pack1::*; 

// Generate clk
bit clk; 
initial begin
    clk = 1 ;
    forever #10 clk = ~clk; 
end

//instantiate interfrace 
intf dct_intf(clk); 

//instantiate dut 
full_dct_transform dut (
    .clk(clk), 
    .rst_n(dct_intf.rst_n), 
    .en(dct_intf.en), 
    .cs(dct_intf.cs), 

    .input0(dct_intf.input0), 
    .input1(dct_intf.input1), 
    .input2(dct_intf.input2), 
    .input3(dct_intf.input3), 
    .input4(dct_intf.input4), 
    .input5(dct_intf.input5), 
    .input6(dct_intf.input6), 
    .input7(dct_intf.input7), 

    .integer_Z0(dct_intf.integer_Z0), 
    .integer_Z1(dct_intf.integer_Z1), 
    .integer_Z2(dct_intf.integer_Z2), 
    .integer_Z3(dct_intf.integer_Z3), 
    .integer_Z4(dct_intf.integer_Z4), 
    .integer_Z5(dct_intf.integer_Z5), 
    .integer_Z6(dct_intf.integer_Z6), 
    .integer_Z7(dct_intf.integer_Z7)
);

//run test
initial begin
    uvm_config_db #(virtual intf)::set(null,"uvm_test_top","my_vif",dct_intf); // my_vif = dct_intf , it now points to it. 
    run_test("my_test"); 
end
endmodule