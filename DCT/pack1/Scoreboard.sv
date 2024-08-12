//Scoreboard 
 class my_scoreboard extends uvm_scoreboard;
    // Factory Registration
    `uvm_component_utils(my_scoreboard)

    //Constructor
    function new(string name = "my_scoreboard", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    // Instantiation: analysis imp
    uvm_analysis_imp #(my_seq_item,my_scoreboard) analysis_export_scoreboard;

    //Instantiation: items queue to hold transactions 
    my_seq_item items_queue[$]; 
    my_seq_item item_t; 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)

    // Constructor: analysis imp
    analysis_export_scoreboard = new("analysis_export_scoreboard",this);
    endfunction: build_phase

    //connect_phase
    function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Connect Phase",UVM_MEDIUM)
    endfunction: connect_phase

    //run_phase
    task run_phase (uvm_phase phase); 
    super.run_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Run Phase",UVM_MEDIUM)

        forever begin
            item_t = my_seq_item::type_id::create("item");
            wait (items_queue.size);  
            item_t =  items_queue.pop_front();
            compare(item_t);
            end
    endtask: run_phase

    function void write(my_seq_item item); 
    items_queue.push_back(item); 
    endfunction: write

    // absolute value function 
    function integer abs( input integer x); 
    if (x<0) abs = -x; 
    else abs = x; 
    endfunction

    // round function 

    // compare function
    function void compare(my_seq_item item) ;
    logic signed [11:0] integer_Z0_t, integer_Z1_t, integer_Z2_t, integer_Z3_t, integer_Z4_t, integer_Z5_t, integer_Z6_t, integer_Z7_t;
    real c1 = 0.9807852804, c2 = 0.92387953251, c3 = 0.8314696123, c4 = 0.70710678118, c5 = 0.55557023302, c6 = 0.38268343236, c7 = 0.19509032201;

    logic signed [11:0] Input0 = item.input0 <<< 1; 
    logic signed [11:0] Input1 = item.input1 <<< 1; 
    logic signed [11:0] Input2 = item.input2 <<< 1; 
    logic signed [11:0] Input3 = item.input3 <<< 1; 
    logic signed [11:0] Input4 = item.input4 <<< 1; 
    logic signed [11:0] Input5 = item.input5 <<< 1; 
    logic signed [11:0] Input6 = item.input6 <<< 1; 
    logic signed [11:0] Input7 = item.input7 <<< 1; 
    
    if(!item.rst_n) begin 

        integer_Z0_t = 0;
        integer_Z1_t = 0;
        integer_Z2_t = 0;
        integer_Z3_t = 0;
        integer_Z4_t = 0;
        integer_Z5_t = 0;
        integer_Z6_t = 0;
        integer_Z7_t = 0;

        $display("Time: %0t", $time, "    Reset Asserted, SB.rst_n = %0d, SB.integer_Z0 = %0d, SB.integer_Z1 = %0d, SB.integer_Z2 = %0d, SB.integer_Z3 = %0d,SB.integer_Z4 = %0d, SB.integer_Z5 = %0d, SB.integer_Z6 = %0d, SB.integer_Z7 = %0d", 
        item.rst_n, item.integer_Z0, item.integer_Z1,item.integer_Z2,item.integer_Z3,item.integer_Z4, item.integer_Z5,item.integer_Z6,item.integer_Z7);
        if(!((integer_Z0_t == item.integer_Z0)&&(integer_Z1_t == item.integer_Z1)&&(integer_Z2_t == item.integer_Z2)&&(integer_Z3_t == item.integer_Z3)&&(integer_Z4_t == item.integer_Z4)&&(integer_Z5_t == item.integer_Z5)&&(integer_Z6_t == item.integer_Z6)&&(integer_Z7_t == item.integer_Z7)))
            `uvm_error(get_type_name(), $sformatf("Reset failure!! the actual integer_Z0= %0d while the expected integer_Z0 = %0d ||| The actual integer_Z1= %0d while the expected integer_Z1 = %0d |||The actual integer_Z2= %0d while the expected integer_Z2 = %0d |||The actual integer_Z3= %0d while the expected integer_Z3 = %0d |||The actual integer_Z4= %0d while the expected integer_Z4 = %0d |||The actual integer_Z5= %0d while the expected integer_Z5 = %0d |||The actual integer_Z6= %0d while the expected integer_Z6 = %0d |||The actual integer_Z7= %0d while the expected integer_Z7 = %0d",
            item.integer_Z0,integer_Z0_t, item.integer_Z1,integer_Z1_t,item.integer_Z2,integer_Z2_t,item.integer_Z3,integer_Z3_t,item.integer_Z4,integer_Z4_t,item.integer_Z5,integer_Z5_t,item.integer_Z6,integer_Z6_t,item.integer_Z7,integer_Z7_t))  
        else $display("Result Reset Scuccessfully");
    end

    else begin 

        // integer_Z0_t = $floor(c4 * (Input0 + Input1 + Input2 + Input3 + Input4 + Input5 + Input6 + Input7));
        // abs((integer_Z0_t  - item.integer_Z0)))<= 2 &&
        integer_Z0_t = $floor(c4 * (Input0 + Input1 + Input2 + Input3 + Input4 + Input5 + Input6 + Input7));
        integer_Z1_t = $floor(c1 * (Input0 - Input7) + c3 * (Input1 - Input6) + c5 * (Input2 - Input5) + c7 * (Input3 - Input4));
        integer_Z2_t = $floor(c2 * (Input0 - Input3 - Input4 + Input7) + c6 * (Input1 - Input2 - Input5 + Input6));
        integer_Z3_t = $floor(c3 * (Input0 - Input7) + c7 * (-Input1 + Input6) + c1 * (-Input2 + Input5) + c5 * (-Input3 + Input4));
        integer_Z4_t = $floor(c4 * (Input0 - Input1 - Input2 + Input3 + Input4 - Input5 - Input6 + Input7));
        integer_Z5_t = $floor(c5 * (Input0 - Input7) + c1 * (-Input1 + Input6) + c7 * (Input2 - Input5) + c3 * (Input3 - Input4));
        integer_Z6_t = $floor(c6 * (Input0 - Input3 - Input4 + Input7) + c2 * (-Input1 + Input2 + Input5 - Input6));
        integer_Z7_t = $floor(c7 * (Input0 - Input7) + c5 * (-Input1 + Input6) + c3 * (Input2 - Input5) + c1 * (-Input3 + Input4));
        //inputs display 
        $display("Time: %0t", $time, "     SB.rst_n = %0d, SB.Input0 = %0d, SB.Input1 = %0d, SB.Input2 = %0d, SB.Input3= %0d,SB.Input4 = %0d, SB.Input5 = %0d, SB.Input6 = %0d, SB.Input7 = %0d", 
        item.rst_n, Input0, Input1,Input2, Input3,Input4, Input5,Input6, Input7);
        //coefficients display
        $display("Time: %0t", $time, "     SB.rst_n = %0d, SB.c1 = %0f, SB.c2 = %0f, SB.c3 = %0f, SB.c4= %0f,SB.c5 = %0f, SB.c6 = %0f, SB.c7 = %0f", 
        item.rst_n, c1, c2,c3, c4,c5, c6,c7);
        //actual outputs display
        $display("Time: %0t", $time, "     SB.rst_n = %0d, SB.integer_Z0 = %0d, SB.integer_Z1 = %0d, SB.integer_Z2 = %0d, SB.integer_Z3 = %0d,SB.integer_Z4 = %0d, SB.integer_Z5 = %0d, SB.integer_Z6 = %0d, SB.integer_Z7 = %0d", 
        item.rst_n,  item.integer_Z0,  item.integer_Z1, item.integer_Z2, item.integer_Z3, item.integer_Z4,  item.integer_Z5, item.integer_Z6, item.integer_Z7);
        
        //expected outputs display
        $display("Time: %0t", $time, "     EEEEEEXPEEEECTED: SB.rst_n = %0d, SB.integer_Z0_t = %0d, SB.integer_Z1_t = %0d, SB.integer_Z2_t = %0d, SB.integer_Z3_t = %0d,SB.integer_Z4_t = %0d, SB.integer_Z5_t = %0d, SB.integer_Z6_t = %0d, SB.integer_Z7_t = %0d", 
        item.rst_n, integer_Z0_t, integer_Z1_t,integer_Z2_t,integer_Z3_t,integer_Z4_t, integer_Z5_t,integer_Z6_t,integer_Z7_t);
        
        if(!(abs((integer_Z1_t  -  item.integer_Z1))<= 2 && abs((integer_Z2_t  -  item.integer_Z2))<= 2 && abs((integer_Z3_t  -  item.integer_Z3))<= 2 &&abs((integer_Z4_t  -  item.integer_Z4))<= 2 &&abs((integer_Z5_t  -  item.integer_Z5))<= 2 &&abs((integer_Z6_t  -  item.integer_Z6))<= 2 &&abs((integer_Z7_t  -  item.integer_Z7))<= 2 ))
            `uvm_error(get_type_name(), $sformatf("failure!! the actual integer_Z0= %0d while the expected integer_Z0 = %0d ||| The actual integer_Z1= %0d while the expected integer_Z1 = %0d |||The actual integer_Z2= %0d while the expected integer_Z2 = %0d |||The actual integer_Z3= %0d while the expected integer_Z3 = %0d |||The actual integer_Z4= %0d while the expected integer_Z4 = %0d |||The actual integer_Z5= %0d while the expected integer_Z5 = %0d |||The actual integer_Z6= %0d while the expected integer_Z6 = %0d |||The actual integer_Z7= %0d while the expected integer_Z7 = %0d",
            item.integer_Z0,integer_Z0_t, item.integer_Z1,integer_Z1_t,item.integer_Z2,integer_Z2_t,item.integer_Z3,integer_Z3_t,item.integer_Z4,integer_Z4_t,item.integer_Z5,integer_Z5_t,item.integer_Z6,integer_Z6_t,item.integer_Z7,integer_Z7_t))  
        else $display("No Errors/ Mismatch found :) ");

    end
    endfunction:compare 

 endclass 
   
