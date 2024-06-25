//sequence item 
 class my_seq_item extends uvm_sequence_item ;
    // Factory Registration
    `uvm_object_utils(my_seq_item)

    //Constructor
    function new(string name = "my_seq_item");
        super.new(name); 
    endfunction 

    //seq_item_signals, DCT signals 

    // Random Variables 
    rand logic rst_n;
    rand logic en;
    rand logic cs;
    rand logic signed [7:0] input0,input1,input2,input3,input4,input5,input6,input7;

    // Non-Random Variables
    logic signed [11:0] integer_Z0,integer_Z1,integer_Z2,integer_Z3,integer_Z4,integer_Z5,integer_Z6,integer_Z7;
    
    //Constraints
    constraint even_numbers { 
      input0[0] == 0; 
      input1[0] == 0; 
      input2[0] == 0; 
      input3[0] == 0;       
      input4[0] == 0;       
      input5[0] == 0;       
      input6[0] == 0;       
      input7[0] == 0;       
    }

    constraint positive_numbers { 
      input0 inside {[-128:127]}; 
      input1 inside {[-128:127]}; 
      input2 inside {[-128:127]}; 
      input3 inside {[-128:127]}; 
      input4 inside {[-128:127]}; 
      input5 inside {[-128:127]}; 
      input6 inside {[-128:127]}; 
      input7 inside {[-128:127]}; 

    }
 endclass: my_seq_item
