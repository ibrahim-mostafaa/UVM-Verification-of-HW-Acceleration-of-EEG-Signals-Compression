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
    
    if(!item.rst_n) begin 
        //for debuging 
        $display("Time: %0t", $time, "    Reset Asserted, SB.rst_n = %0d, SB.Output = %0d, SB.Counter = %0d", 
        item.rst_n, item.Output, item.Counter);

        if(!((item.Counter == 0 )&&(item.Output == 0)))
            `uvm_error(get_type_name(), $sformatf("Reset failure!! the actual Output = %0d and the actual Counter= %0d  |||||  expected Output = 0 and expected Counter = 0  "
            ,item.Output,item.Counter)) 
        else $display("Result Reset Scuccessfully");
    end

    else begin 
        $display("------------------------------------------****** Scoreboard ******--------------------------------------------------------");
    $display("Time: %0t", $time, "   SB.rst_n = %0d,SB.Input = %0d, SB.rand_in_count = %0d, SB.Output = %0d, SB.Counter = %0d",
    item.rst_n,item.Input, item.rand_in_count, item.Output, item.Counter);
        if(!((item.rand_in_count == item.Counter)&&(item.Input == item.Output)))
            `uvm_error(get_type_name(), $sformatf("failure!! the actual Output = %0d and the actual Counter= %0d  |||||  expected Output = %0d and expected Counter = %0d  "
            ,item.Output,item.Counter,item.Input,item.rand_in_count))  
        else begin $display("No Errors/ Mismatch found :) "); 
        $display("------------------------------------------***********************--------------------------------------------------------");
        end
    end
    endfunction:compare 

 endclass 
   