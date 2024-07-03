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

   //pre-body task
   task pre_body(); 
   item = my_seq_item::type_id::create("item");
   endtask: pre_body

    //Body task
    task body();
    
      assert (item.randomize() with {rst_n == 0;}) 
      else   $display("Reset Randomization Failed ..... ");

     start_item(item);
     finish_item(item);

     $display("Time: %0t ",$time, "     Generate Reset item:    rst_n = %0d, input1 = %0d,  input2= %0d",item.rst_n,item.input1,item.input2);
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

   //pre-body task
   task pre_body(); 
   item = my_seq_item::type_id::create("item");
   endtask: pre_body

    //Body task
    task body();
      // random test cases 
      assert (item.randomize() with {rst_n == 1;}) 
      else   $display("Test Randomization Failed ..... ");

     start_item(item);
     finish_item(item);

    $display("Time: %0t ",$time, "  Generate Random Test item:   input1 = %0d, input2 = %0d",item.input1,item.input2);
    endtask: body
 endclass: Random_Sequence
 
// Corner_Sequence
 class Corner_Sequence extends Base_Sequence ;
    // Factory Registration
    `uvm_object_utils(Corner_Sequence)

   typedef struct {
      logic [7:0] input1;
      logic [7:0] input2;
   }  Combination_t;

   //Dynamic array of structs to hold combinatons of corner test cases
   Combination_t Combinations []; 

    //Constructor
    function new(string name = "Corner_Sequence");
        super.new(name);   
    endfunction 

    // Instantiate Seq_Item
    my_seq_item item; 

   //pre-body task
   task pre_body(); 
   item = my_seq_item::type_id::create("item");

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
   endtask: pre_body

    //Body task
    task body();
    // rand_i randomizes which elemnt of combinations array to be chosen
    int rand_i = $urandom_range(0,Combinations.size()-1);
    //int rand_i = $urandom % Combinations.size();   

    Combination_t curr_compination = Combinations [rand_i]; 

   //pattern randomizes the combination between random and corner case
   // 3 cases: [0] input1 corner case, input2 random --- [1] input1 random, input2 corner case  ----- [2] input1 corner case, input2 corner case
    int pattern = $urandom_range(0,2);  
    //int pattern = $urandom % 3;   

   //  item = my_seq_item::type_id::create("item");
     
   // Randomize the corner case test cases, and start item
   case (pattern) 
   0: begin 
      // input1 corner case, input2 random
        assert (item.randomize() with {
         rst_n == 1;
         input1 == curr_compination.input1;
         //input2 random
         }) 
        else   $display("Corner test case Failed (input1 corner case, input2 random)..... ");
   end 
   1: begin 
      // input1 random, input2 corner case
        assert (item.randomize() with {
         rst_n == 1;
         //input1 random
         input2 == curr_compination.input2;
         }) 
        else   $display("Corner test case Failed (input1 random, input2 corner case)..... ");
   end 
   2: begin 
      // input1 corner case, input2 corner case
        assert (item.randomize() with {
         rst_n == 1;
         input1 == curr_compination.input1;
         input2 == curr_compination.input2;
         }) 
        else   $display("Corner test case Failed (input1 corner case, input2 corner case)..... ");
   end
   endcase 

   start_item(item);
   finish_item(item);

    $display("Time: %0t ",$time, "  Generate Corner test case item:   input1 = %0d, input2 = %0d",item.input1,item.input2);
    endtask: body
 endclass: Corner_Sequence