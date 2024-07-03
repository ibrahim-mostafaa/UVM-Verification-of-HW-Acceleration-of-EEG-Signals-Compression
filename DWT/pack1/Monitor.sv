//Monitor 
 class my_monitor extends uvm_monitor;
    // Factory Registration
    `uvm_component_utils(my_monitor)  

    //Constructor
    function new(string name = "my_monitor", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //Instantiation of analysis port
    uvm_analysis_port #(my_seq_item) analysis_port_monitor;

    //Instantiation of virtual interface
    virtual intf config_intf; 
    virtual intf local_intf; 

    //Instantiation: item
    my_seq_item current_item, next_item; 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)

    // get from config_db
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",config_intf))
        `uvm_fatal(get_full_name(),"Error!")

    local_intf = config_intf; 

    //Constructor: handle of analysis port
    analysis_port_monitor = new("analysis_port_monitor",this);

    // create sequence items current_item, next_item
    current_item = my_seq_item::type_id::create("current_item");
    next_item = my_seq_item::type_id::create("next_item");
    
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

    //wait(local_intf.rst_n);
    @(local_intf.cb); 
        //get inputs of next cycle
    next_item.input1 = local_intf.cb.input1;
    next_item.input2 = local_intf.cb.input2;
        // get results of current cycle 
    current_item.rst_n = local_intf.rst_n;
    current_item.average = local_intf.cb.average;
    current_item.difference  = local_intf.cb.difference;
        // write the current cylce values
    analysis_port_monitor.write(current_item);
    // for debuging 
    // $display("Time: %0t ", $time, "Monitor.input1 = %0d, Monitor.input2 = %0d, Monitor.average = %0d, Monitor.difference = %0d", 
    // current_item.input1,current_item.input2,current_item.average,current_item.difference);
        
        // transfer signals to current_item 
    current_item.input1 <= next_item.input1;
    current_item.input2 <= next_item.input2;
    end

    endtask: run_phase

 endclass 
