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

    // Non-Random Variables
    logic [7:0] Counter;
    logic signed [8:0] Output;

    //Number of repetitions
    //int rand_in_count = $urandom_range (1,4); 
    rand int rand_in_count ; 

    constraint c_count { 
        //rand_in_count > 1; 
        rand_in_count inside {[1:100]};
    }

 endclass: my_seq_item
