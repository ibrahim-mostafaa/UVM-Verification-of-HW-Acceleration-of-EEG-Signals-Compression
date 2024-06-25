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
    virtual interface intf config_intf; 
    virtual interface intf local_intf; 

    //Instantiation: item
    my_seq_item current_item, next_item; 

    //Instantiation: items queue to hold transactions 
    //my_seq_item items_queue[$]; 

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

    current_item = my_seq_item::type_id::create("current_item");
    next_item = my_seq_item::type_id::create("next_item");

    forever begin 

    wait(local_intf.rst_n);
    repeat(8) @(local_intf.cb); 
        //get inputs of next cycle
    next_item.en = local_intf.cb.en;
    next_item.cs = local_intf.cb.cs;
    next_item.rst_n = local_intf.rst_n;

    next_item.input0 = local_intf.cb.input0;
    next_item.input1 = local_intf.cb.input1;
    next_item.input2 = local_intf.cb.input2;
    next_item.input3 = local_intf.cb.input3;
    next_item.input4 = local_intf.cb.input4;
    next_item.input5 = local_intf.cb.input5;
    next_item.input6 = local_intf.cb.input6;
    next_item.input7 = local_intf.cb.input7;

        // get results of current cycle 
    // current_item.rst_n = local_intf.rst_n;
    current_item.integer_Z0 = local_intf.cb.integer_Z0;
    current_item.integer_Z1 = local_intf.cb.integer_Z1;
    current_item.integer_Z2 = local_intf.cb.integer_Z2;
    current_item.integer_Z3 = local_intf.cb.integer_Z3;
    current_item.integer_Z4 = local_intf.cb.integer_Z4;
    current_item.integer_Z5 = local_intf.cb.integer_Z5;
    current_item.integer_Z6 = local_intf.cb.integer_Z6;
    current_item.integer_Z7 = local_intf.cb.integer_Z7;
    
        // write the current cylce values
    analysis_port_monitor.write(current_item);
    // for debuging
    // inputs  
    $display("Time: %0t ", $time, "Monitor.EN = %0d, Monitor.CS = %0d,Monitor.rst_n = %0d, Monitor.input0 = %0d, Monitor.input1 = %0d, Monitor.input2 = %0d, Monitor.input3 = %0d, Monitor.input4 = %0d, Monitor.input5 = %0d, Monitor.input6 = %0d, Monitor.input7 = %0d,", 
    current_item.en,current_item.cs,current_item.rst_n,current_item.input0<<< 1,current_item.input1<<< 1,current_item.input2<<< 1,current_item.input3<<< 1,current_item.input4<<< 1,current_item.input5<<< 1,current_item.input6<<< 1,current_item.input7<<< 1);

        // output  
    $display("Time: %0t ", $time, "Monitor.integer_Z0 = %0d, Monitor.integer_Z1 = %0d, Monitor.integer_Z2 = %0d, Monitor.integer_Z3 = %0d, Monitor.integer_Z4 = %0d, Monitor.integer_Z5 = %0d, Monitor.integer_Z6 = %0d, Monitor.integer_Z7 = %0d,", 
    current_item.integer_Z0,current_item.integer_Z1,current_item.integer_Z2,current_item.integer_Z3,current_item.integer_Z4,current_item.integer_Z5,current_item.integer_Z6,current_item.integer_Z7);

          
        // transfer signals to current_item 
    current_item.en <= next_item.en;
    current_item.cs <= next_item.cs;
    current_item.rst_n <= next_item.rst_n;

    current_item.input0 <= next_item.input0;
    current_item.input1 <= next_item.input1;
    current_item.input2 <= next_item.input2;
    current_item.input3 <= next_item.input3;
    current_item.input4 <= next_item.input4;
    current_item.input5 <= next_item.input5;
    current_item.input6 <= next_item.input6;
    current_item.input7 <= next_item.input7;
    end

    endtask: run_phase

 endclass 
