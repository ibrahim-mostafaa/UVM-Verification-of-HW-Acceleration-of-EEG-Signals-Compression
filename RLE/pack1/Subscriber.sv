//Subscriber 
 class my_subscirber extends uvm_subscriber #(my_seq_item);
    // Factory Registration
    `uvm_component_utils(my_subscirber)

    // Coverage definition: 
    covergroup Design_signals;
        //option.per_instance=1;
        reset_case: coverpoint item.rst_n;
        
        Input_case: coverpoint item.Input iff (item.rst_n) { // sample only if rst_n is deasserted 
            bins Input_Lowest_negative = {8'b10000000};
            bins Input_Highest_positive = {8'b01111111};
            bins Input_all_zeros={8'b0};
            bins Input_neg = {[$:-1]};
            bins Input_pos = {[1:$]};
            bins random_data=default;
        }
        //Cross Coverage

    endgroup: Design_signals

    //Constructor
    function new(string name = "my_subscriber", uvm_component parent);
        super.new(name,parent); 
        Design_signals = new();
    endfunction 

    // // Instantiation: analysis imp
    // uvm_analysis_imp #(my_seq_item,my_subscirber) analysis_export_subscriber;
    //Instantiation: item
    my_seq_item item; 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)
        // Constructor: analysis imp
    // analysis_export_subscriber = new("analysis_export_subscriber",this);
    //item = my_seq_item::type_id::create("item");

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
    endtask: run_phase


    //override pure virtual function void
    function void write(my_seq_item t); 
    $cast(item,t);
    Design_signals.sample();
    $display("Final Coverage --------------------> %0.2f%%",Design_signals.get_coverage());
    endfunction: write
 endclass 
