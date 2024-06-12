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
    $display("Time: %0t ",$time, "     Generate Reset item:    rst_n = %0d, input1 = %0d,  input2= %0d",item.rst_n,item.input1,item.input2);
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
     start_item(item);
      // random test cases 
        assert (item.randomize() with {rst_n == 1;}) 
        else   $display("Test Randomization Failed ..... ");
     finish_item(item);
    $display("Time: %0t ",$time, "  Generate Random Test item:   input1 = %0d, input2 = %0d",item.input1,item.input2);
    endtask: body
 endclass: Test_Sequence
 
// Direct_Sequence
 class Direct_Sequence extends Base_Sequence ;
    // Factory Registration
    `uvm_object_utils(Direct_Sequence)

   typedef struct {
      logic [7:0] input1;
      logic [7:0] input2;
   }  Combination_t;
   //Array of structs to hold combinatons of directed test cases
   Combination_t Combinations []; 

    //Constructor
    function new(string name = "Direct_Sequence");
        super.new(name);  
        Combinations = new[9]; 
        Combinations[0] = '{8'b0,8'b0}; 
        Combinations[1] = '{8'b0,8'b10000000}; 
        Combinations[2] = '{8'b0,8'b01111111}; 

        Combinations[3] = '{8'b01111111,8'b0}; 
        Combinations[4] = '{8'b01111111,8'b01111111}; 
        Combinations[5] = '{8'b01111111,8'b10000000}; 

        Combinations[6] = '{8'b10000000,8'b0}; 
        Combinations[7] = '{8'b10000000,8'b01111111}; 
        Combinations[8] = '{8'b10000000,8'b10000000};  

      
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
   // 3 cases: [0] input1 directed, input2 random --- [1] input1 random, input2 directed  ----- [2] input1 directed, input2 directed
    int pattern = $urandom_range(0,2);  
    //int pattern = $urandom % 3;   
    item = my_seq_item::type_id::create("item");
     
   // Randomize the directed test cases, and start item
   start_item(item);
   case (pattern) 
   0: begin 
      // input1 directed, input2 random
        assert (item.randomize() with {
         rst_n == 1;
         input1 == curr_compination.input1;
         //input2 random
         }) 
        else   $display("Directed Test Failed (input1 directed, input2 random)..... ");
   end 
   1: begin 
      // input1 random, input2 directed
        assert (item.randomize() with {
         rst_n == 1;
         //input1 random
         input2 == curr_compination.input2;
         }) 
        else   $display("Directed Test Failed (input1 random, input2 directed)..... ");
   end 
   2: begin 
      // input1 directed, input2 directed
        assert (item.randomize() with {
         rst_n == 1;
         input1 == curr_compination.input1;
         input2 == curr_compination.input2;
         }) 
        else   $display("Directed Test Failed (input1 directed, input2 directed)..... ");
   end
   endcase 
   finish_item(item);

    $display("Time: %0t ",$time, "  Generate Directed Test item:   input1 = %0d, input2 = %0d",item.input1,item.input2);
    endtask: body
 endclass: Direct_Sequence