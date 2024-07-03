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
    $display(" INSIDE MONITOR: RESET_N = %0d", local_intf.rst_n);
    repeat(local_intf.cb.rand_in_count-1) @(local_intf.cb); 

        //get inputs of next cycle
    next_item.Input <= local_intf.cb.Input;
    next_item.rand_in_count <= local_intf.cb.rand_in_count;
    @(local_intf.cb);
        // get results of current cycle 
    current_item.rst_n = local_intf.rst_n;
    current_item.Output = local_intf.cb.Output;
    current_item.Counter  = local_intf.cb.Counter;
        // write the current cylce values
    analysis_port_monitor.write(current_item);
        // transfer signals to current_item 
    //wait(local_intf.rst_n);
    // if(!local_intf.rst_n) begin 
    // current_item.Input = next_item.Input; 
    // current_item.rand_in_count = next_item.rand_in_count;
    // end 
    // else begin 
    current_item.Input <= next_item.Input; 
    current_item.rand_in_count <= next_item.rand_in_count;
    // end 
        // for debuging 
    $display("Time: %0t ", $time, "Monitor.Input = %0d, Monitor.rand_in_count = %0d, Monitor.Output = %0d, Monitor.Counter = %0d", 
    current_item.Input,current_item.rand_in_count,current_item.Output,current_item.Counter);

    end

    endtask: run_phase

 endclass 
