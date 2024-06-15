//Base_Sequence 
 class Base_Sequence extends uvm_sequence;
    // Factory Registration
    `uvm_object_utils(Base_Sequence)

    //Constructor
    function new(string name = "Base_Sequence");
        super.new(name); 
    endfunction 
 endclass: Base_Sequence

// Reset_Sequence
 class Reset_Sequence extends Base_Sequence ;
    // Factory Registration
    `uvm_object_utils(Reset_Sequence)

    //Constructor
    function new(string name = "Reset_Sequence");
        super.new(name); 
    endfunction 

    // Instantiate Seq_Item
    my_seq_item item; 

    //Body task
    task body();
    item = my_seq_item::type_id::create("item");
     start_item(item);
        assert (item.randomize() with {rst_n == 0;}) 
        else   $display("Reset Randomization Failed ..... ");
     finish_item(item);
    $display("Time: %0t ",$time, "     Generate Reset item:    rst_n = %0d, Input = %0d",item.rst_n,item.Input);
    endtask: body
 endclass: Reset_Sequence

// Test_Sequence
 class Test_Sequence extends Base_Sequence ;
    // Factory Registration
    `uvm_object_utils(Test_Sequence)

    //Constructor
    function new(string name = "Test_Sequence");
        super.new(name); 
    endfunction 

    // Instantiate Seq_Item
    my_seq_item item; 

    //Body task
    task body();

    //initial value of the previous input 
   static int previous_input = -1; 

   item = my_seq_item::type_id::create("item");

    // random test cases 
    assert (item.randomize() with {
      rst_n == 1;
      Input != previous_input;}) 
    else   $display("Test Randomization Failed ..... ");

   repeat(item.rand_in_count) begin 
      start_item(item);
      finish_item(item);
   end 
   previous_input = item.Input; 

   $display("Time: %0t ",$time, "  Generate Random Test item:   Input = %0d, Repetitios = %0d",item.Input, item.rand_in_count);

    endtask: body
 endclass: Test_Sequence
 