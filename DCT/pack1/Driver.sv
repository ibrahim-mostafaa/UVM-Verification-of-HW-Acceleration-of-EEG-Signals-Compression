//Driver 
 class my_driver extends uvm_driver #(my_seq_item);
    // Factory Registration
    `uvm_component_utils(my_driver)

    //Constructor
    function new(string name = "my_driver", uvm_component parent);
        super.new(name,parent); 
    endfunction 

    //Instantiation of virtual interface
    virtual interface intf config_intf; 
    virtual interface intf local_intf;

    //Instanitation: item_driv
    my_seq_item item_driv; 

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
    item_driv = my_seq_item::type_id::create("item_driv");
    seq_item_port.get_next_item(item_driv);
    drive(item_driv); 
    seq_item_port.item_done();
    $display("********************** Driver ****************************");
    $display("Time: %0t ", $time, "Driver.EN = %0d, Driver.CS = %0d, Driver.input0 = %0d, Driver.input1 = %0d, Driver.input2 = %0d, Driver.input3 = %0d, Driver.input4 = %0d, Driver.input5 = %0d, Driver.input6 = %0d, Driver.input7 = %0d,", 
    item_driv.en,item_driv.cs,item_driv.input0 ,item_driv.input1,item_driv.input2,item_driv.input3,item_driv.input4,item_driv.input5,item_driv.input6,item_driv.input7);
    end 
    endtask: run_phase

    task drive (my_seq_item item_driv);
    // Asynch reset 
    local_intf.rst_n <= item_driv.rst_n; 
    //$display("Time: %0t", $time, "  driver.rst_n = ", item_driv.rst_n);
    @(local_intf.cb) begin

    local_intf.cb.en <= item_driv.en; 
    local_intf.cb.cs <= item_driv.cs; 
    // to put the inputs in fixed point format, 1 bit for integer, 7 for fraction.
    local_intf.cb.input0 <= item_driv.input0 >>> 1; 
    local_intf.cb.input1 <= item_driv.input1 >>> 1; 
    local_intf.cb.input2 <= item_driv.input2 >>> 1; 
    local_intf.cb.input3 <= item_driv.input3 >>> 1; 
    local_intf.cb.input4 <= item_driv.input4 >>> 1; 
    local_intf.cb.input5 <= item_driv.input5 >>> 1; 
    local_intf.cb.input6 <= item_driv.input6 >>> 1; 
    local_intf.cb.input7 <= item_driv.input7 >>> 1; 

    end
    //$display("Driver Port Done"); 
    endtask 

 endclass 
