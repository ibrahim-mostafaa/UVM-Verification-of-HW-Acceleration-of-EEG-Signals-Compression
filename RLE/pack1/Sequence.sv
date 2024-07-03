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

   //pre_body task
   task pre_body(); 
   item = my_seq_item::type_id::create("item");
   endtask: pre_body

    //body task
    task body();

      assert (item.randomize() with {rst_n == 0;}) 
      else   $display("Reset Randomization Failed ..... ");

     start_item(item);
     finish_item(item);

    $display("Time: %0t ",$time, "     Generate Reset item:    rst_n = %0d, Input = %0d",item.rst_n,item.Input);
    endtask: body
 endclass: Reset_Sequence

// Random_Sequence
 class Random_Sequence extends Base_Sequence ;
    // Factory Registration
    `uvm_object_utils(Random_Sequence)

    //Constructor
    function new(string name = "Random_Sequence");
        super.new(name); 
    endfunction 

    // Instantiate Seq_Item
    my_seq_item item; 

   //pre_body task
   task pre_body(); 
   item = my_seq_item::type_id::create("item");
   endtask: pre_body

    //Body task
    task body();

    //initial value of the previous input 
   static int previous_input = -1; 
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
 endclass: Random_Sequence
 