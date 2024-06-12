//sequence item 
 class my_seq_item extends uvm_sequence_item ;
    // Factory Registration
    `uvm_object_utils(my_seq_item)

    //Constructor
    function new(string name = "my_seq_item");
        super.new(name); 
    endfunction 

    //seq_item_signals, RLE signals 

    // Random Variables 
    rand logic rst_n;
    rand logic signed [8:0] Input;
    //Number of repetitions
    int rand_in_count = $urandom_range(1,4); 

    // Non-Random Variables
    logic [7:0] Counter;
    logic signed [8:0] Output;
    
   //  //Constraints
    // constraint c1 { 
    //   rand_in_count inside {[0:100]};
    // }

 endclass: my_seq_item
