//Agent 
 class my_agent extends uvm_agent;
    // Factory Registration
    `uvm_component_utils(my_agent)

    //Constructor
    function new(string name = "my_agent", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //instantiation: sequencer, driver
    my_driver driver;
    my_sequencer sequencer; 
    my_monitor monitor; 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)
    //Constructor: driver, sequencer, monitor 
    driver = my_driver::type_id::create("driver",this); 
    sequencer = my_sequencer::type_id::create("sequencer",this); 
    monitor = my_monitor::type_id::create("monitor",this); 

    endfunction

    //connect_phase
    function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Connect Phase",UVM_MEDIUM)
   
    //Connect driver with sequencer. 
    driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

    //run_phase
    task run_phase (uvm_phase phase); 
    super.run_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Run Phase",UVM_MEDIUM)
    endtask

 endclass: my_agent 
  