//test 
 class my_test extends uvm_test;
     // Factory Registration
    `uvm_component_utils(my_test)
    
    //instantiation: Env, reset_seq, random_seq
    my_env env; 
    Reset_Sequence rst_seq;
    Random_Sequence random_seq; 

    //Constructor
    function new(string name = "my_test", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //Instantiation of virtual interface
    virtual intf config_intf; 
    virtual intf local_intf; 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)
    //Constructor: Env
    env = my_env::type_id::create("env",this); 

    //get from Config_db
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",config_intf)) 
        `uvm_fatal(get_full_name(),"Error!")
    
    local_intf = config_intf;
    //set vif Driver & Monitor 
    uvm_config_db #(virtual intf)::set(this,"env.agent.driver","my_vif",local_intf);
    uvm_config_db #(virtual intf)::set(this,"env.agent.monitor","my_vif",local_intf);
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
    
    phase.raise_objection(this);
    // // Start reset_seq  
        rst_seq = Reset_Sequence::type_id::create("rst_seq");
        rst_seq.start(env.agent.sequencer); 
        #10; 
        
    // Start random_seq
        repeat(500) begin 
        random_seq = Random_Sequence::type_id::create("random_seq");
        random_seq.start(env.agent.sequencer); 
        #10; 
        end

    phase.drop_objection(this);
    endtask: run_phase

 endclass: my_test
  