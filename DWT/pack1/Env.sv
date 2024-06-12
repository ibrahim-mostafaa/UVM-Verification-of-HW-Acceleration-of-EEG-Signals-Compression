//Env 
 class my_env extends uvm_env;
    // Factory Registration
    `uvm_component_utils(my_env)

    //Constructor
    function new(string name = "my_env", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //instantiation: subs, agent, scoreb
    my_subscirber subscriber; 
    my_scoreboard scoreboard;
    my_agent agent;

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)
    //Constructor: Env
    agent = my_agent::type_id::create("agent",this);
    scoreboard = my_scoreboard::type_id::create("scoreboard",this); 
    subscriber = my_subscirber::type_id::create("subscriber",this); 
    endfunction

    //connect_phase
    function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Connect Phase",UVM_MEDIUM)

    //Connect monitor with scoreboard & Subsriber
    agent.monitor.analysis_port_monitor.connect(scoreboard.analysis_export_scoreboard);
    agent.monitor.analysis_port_monitor.connect(subscriber.analysis_export);  // already was there. not in build phase
    endfunction

    //run_phase
    task run_phase (uvm_phase phase); 
    super.run_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Run Phase",UVM_MEDIUM)
    endtask

 endclass: my_env
  