//Driver 
 class my_driver extends uvm_driver #(my_seq_item);
    // Factory Registration
    `uvm_component_utils(my_driver)

    //Constructor
    function new(string name = "my_driver", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //Instantiation of virtual interface
    virtual intf config_intf; 
    virtual intf local_intf;

    //Instanitation: item_driv
    my_seq_item item_driv; 

    //phases 
    //build_phase
    function void build_phase (uvm_phase phase); 
    super.build_phase(phase);
    //Display 
    `uvm_info(get_type_name(),"Build Phase",UVM_MEDIUM)

    item_driv = my_seq_item::type_id::create("item_driv");

    // get from config_db
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",config_intf))
        `uvm_fatal(get_full_name(),"Error!")

    local_intf = config_intf; 
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

    //Receive transactions for sequencer 
    forever begin 
    seq_item_port.get_next_item(item_driv);
    drive(item_driv); 
    seq_item_port.item_done();
    //for debuging
    $display("********************** Driver ****************************");
    $display("Time: %0t",$time, "      driver.rst_n = %0d, driver.Input = %0d, driver.rand_in_count = %0d",
    item_driv.rst_n,item_driv.Input,item_driv.rand_in_count);
    end 
    endtask: run_phase

    task drive (my_seq_item item_driv);
    // Asynch reset 
    local_intf.rst_n <= item_driv.rst_n; 
    // $display("Time: %0t", $time, "  driver.rst_n = ", item_driv.rst_n);
    @(local_intf.cb) begin
    local_intf.cb.Input <= item_driv.Input; 
    local_intf.cb.rand_in_count <= item_driv.rand_in_count; 
    end
    endtask 

 endclass 
