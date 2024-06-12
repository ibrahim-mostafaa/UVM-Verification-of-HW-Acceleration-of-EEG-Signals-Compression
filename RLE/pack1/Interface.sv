//Interface
interface intf(input logic clk);

  // ALU signals
    logic rst_n;
    logic signed [8:0] Input;

    logic [7:0] Counter ;
    logic signed [8:0] Output;
  // number of Repetitions
    int rand_in_count; 


//clocking block
clocking cb @(posedge clk);
default input #0 output negedge; 
//output rst_n;
output Input; 
output posedge rand_in_count; 
input Output, Counter;
endclocking 

endinterface //intf
