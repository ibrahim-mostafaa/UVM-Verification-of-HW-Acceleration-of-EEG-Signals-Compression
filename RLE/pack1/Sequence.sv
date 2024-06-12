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

   item = my_seq_item::type_id::create("item");

   // // randomize number of input repetetions
   // item.rand_in_count = $urandom_range(0,100); 

    // random test cases 
    assert (item.randomize() with {rst_n == 1;}) 
    else   $display("Test Randomization Failed ..... ");

    repeat(item.rand_in_count) begin 

      start_item(item);
      finish_item(item);
      $display("Time: %0t ",$time, "  Generate Random Test item:   Input = %0d, Repetitios = %0d",item.Input, item.rand_in_count);

    end 
    endtask: body
 endclass: Test_Sequence
 
// Direct_Sequence
 class Direct_Sequence extends Base_Sequence ;
    // Factory Registration
    `uvm_object_utils(Direct_Sequence)

   typedef struct {
      logic [8:0] Input;
   }  Combination_t;

   //Array of structs to hold combinatons of directed test cases
   Combination_t Combinations []; 

    //Constructor
    function new(string name = "Direct_Sequence");
        super.new(name);  
        Combinations = new[3]; 
        Combinations[0] = '{9'b0}; 
        Combinations[1] = '{9'b10000000}; 
        Combinations[2] = '{9'b01111111}; 
    endfunction 

    // Instantiate Seq_Item
    my_seq_item item; 

    //Body task
    task body();
    // rand_i randomizes choice of array elements
    int rand_i = $urandom_range(0,Combinations.size()-1);
    //int rand_i = $urandom % Combinations.size();    
    Combination_t curr_compination = Combinations [rand_i]; 

   //pattern randomizes the combination between random and directed 
   // 2 cases: [0] Input directed, --- [1] Input random,  
    int pattern = $urandom_range(0,1);  
    //int pattern = $urandom % 3; 

    item = my_seq_item::type_id::create("item");

   // Randomize the directed test cases, and start item
      case (pattern) 
      0: begin 
         // Input directed
         assert (item.randomize() with {
            rst_n == 1;
            Input == curr_compination.Input;
            }) 
         else   $display("Directed Test Failed (Input directed)..... ");
      end 
      1: begin 
         // Input random
         assert (item.randomize() with {
            rst_n == 1;
            //Input random
            }) 
         else   $display("Directed Test Failed (Input random)..... ");
      end 
      endcase 
      
   repeat(item.rand_in_count) begin 
      start_item(item);
      finish_item(item);

      $display("Time: %0t ",$time, "  Generate Directed Test item:   Input = %0d, Repetitios = %0d",item.Input, item.rand_in_count);
  end

    endtask: body
 endclass: Direct_Sequence