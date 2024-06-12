//sequence item 
 class my_seq_item extends uvm_sequence_item ;
    // Factory Registration
    `uvm_object_utils(my_seq_item)

    //Constructor
    function new(string name = "my_seq_item");
        super.new(name); 
    endfunction 

    //seq_item_signals, DWT signals 

    // Random Variables 
    rand logic rst_n;
    rand logic signed [7:0] input1, input2;

    // Non-Random Variables
    logic signed [7:0] average, difference;
    
   //  //Constraints
   //  constraint c1 { 
   //  }

 endclass: my_seq_item
