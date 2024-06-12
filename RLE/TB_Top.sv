//Testbench
`include "uvm_pkg.sv"
`include "pack1.sv"
`include "Interface.sv"
`include "rle.v"

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
intf rle_intf(clk); 

//instantiate dut 
rle dut (
    .clk(clk), 
    .rst_n(rle_intf.rst_n), 
    .Input(rle_intf.Input), 
    .Output(rle_intf.Output),  
    .Counter(rle_intf.Counter)
);

//run test
initial begin
    uvm_config_db #(virtual intf)::set(null,"uvm_test_top","my_vif",rle_intf); // my_vif = rle_intf , it now points to it. 
    run_test("my_test"); 
end
endmodule