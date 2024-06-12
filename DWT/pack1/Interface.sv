//Interface
interface intf(input logic clk);

  // ALU signals
    logic rst_n;
    logic signed [7:0] input1, input2;

    logic signed [8:0] average, difference;


//clocking block
clocking cb @(posedge clk);
default input #0 output negedge; 
//output rst_n;
output input1, input2; 
input average, difference;
endclocking 

endinterface //intf
