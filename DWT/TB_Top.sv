//Testbench
`include "uvm_pkg.sv"
`include "pack1.sv"
`include "Interface.sv"
`include "dwt.v"

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
intf dwt_intf(clk); 

//instantiate dut 
dwt dut (
    .clk(clk), 
    .rst_n(dwt_intf.rst_n), 
    .input1(dwt_intf.input1), 
    .input2(dwt_intf.input2), 
    .average(dwt_intf.average), 
    .difference(dwt_intf.difference)
);

//run test
initial begin
    uvm_config_db #(virtual intf)::set(null,"uvm_test_top","my_vif",dwt_intf); // my_vif = dwt_intf , it now points to it. 
    run_test("my_test"); 
end
endmodule