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

    function void compare(my_seq_item item) ;
    logic signed [8:0] average_t, difference_t;
    if(!item.rst_n) begin 
        average_t = 0;
        difference_t = 0; 
        $display("Time: %0t", $time, "    Reset Asserted, SB.rst_n = %0d, SB.average = %0d, SB.difference = %0d", 
        item.rst_n, item.average, item.difference);
        if(!((average_t == item.average)&&(difference_t == item.difference)))
            `uvm_error(get_type_name(), $sformatf("Reset failure!! the actual average= %0d while the expected average= %0d ||| the actual difference= %0d while the expected difference= %0d",
            item.average,average_t, item.difference,difference_t))  
        else $display("Result Reset Scuccessfully");
    end

    else begin 
        average_t = (item.input1 + item.input2) >>>1;  
        difference_t = (item.input1 - item.input2) >>>1;  

    $display("Time: %0t", $time, "   SB.rst_n = %0d,SB.input1 = %0d, SB.input2 = %0d, SB.average = %0d, SB.difference = %0d",
    item.rst_n,item.input1, item.input2, item.average, item.difference);
        if(!((average_t == item.average)&&(difference_t == item.difference)))
            `uvm_error(get_type_name(), $sformatf("failure!! the actual average = %0d while the expected average= %0d  |||||  actual difference = %0d while expected difference = %0d  "
            ,item.average,average_t,item.difference,difference_t))  
        else $display("No Errors/ Mismatch found :) "); 
    end
    endfunction:compare 

 endclass 
   