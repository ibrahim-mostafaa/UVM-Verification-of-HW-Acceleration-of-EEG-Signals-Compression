//Interface
interface intf(input logic clk);

  // DCT signals
    logic rst_n;
    logic en;
    logic cs;

    logic signed [7:0] input0,input1,input2,input3,input4,input5,input6,input7;

    logic signed [11:0] integer_Z0,integer_Z1,integer_Z2,integer_Z3,integer_Z4,integer_Z5,integer_Z6,integer_Z7;

//clocking block
clocking cb @(posedge clk);
default input #0 output negedge; 
//output rst_n;
output en,cs;
output input0,input1,input2,input3,input4,input5,input6,input7; 
input integer_Z0,integer_Z1,integer_Z2,integer_Z3,integer_Z4,integer_Z5,integer_Z6,integer_Z7;
endclocking 

endinterface //intf
