//Subscriber 
 class my_subscirber extends uvm_subscriber #(my_seq_item);
    // Factory Registration
    `uvm_component_utils(my_subscirber)

    // Coverage definition: 
    covergroup Design_signals;
        //option.per_instance=1;
        reset_case:coverpoint item.rst_n;

        enable_case:coverpoint item.en;
        
        input0_case: coverpoint item.input0 iff (item.rst_n) { // sample only if rst_n is deasserted 
            bins input0_Lowest_negative = {8'b10000000};
            bins input0_Highest_positive = {8'b01111111};
            bins input0_all_zeros={8'b0};
            bins input0_neg = {[$:-1]};
            bins input0_pos = {[1:$]};
            bins random_data=default;
        }        
        input1_case: coverpoint item.input1 iff (item.rst_n) { // sample only if rst_n is deasserted 
            bins input1_Lowest_negative = {8'b10000000};
            bins input1_Highest_positive = {8'b01111111};
            bins input1_all_zeros={8'b0};
            bins input1_neg = {[$:-1]};
            bins input1_pos = {[1:$]};
            bins random_data=default;
        }
        input2_case: coverpoint item.input2 iff (item.rst_n) {
            bins input2_Lowest_negative = {8'b10000000};
            bins input2_Highest_positive = {8'b01111111};
            bins input2_all_zeros={8'b0};
            bins input2_neg = {[$:-1]};
            bins input2_pos = {[1:$]};
            bins random_data=default;
        }
        input3_case: coverpoint item.input3 iff (item.rst_n) {
            bins input3_Lowest_negative = {8'b10000000};
            bins input3_Highest_positive = {8'b01111111};
            bins input3_all_zeros={8'b0};
            bins input3_neg = {[$:-1]};
            bins input3_pos = {[1:$]};
            bins random_data=default;
        }
        input4_case: coverpoint item.input4 iff (item.rst_n) {
            bins input4_Lowest_negative = {8'b10000000};
            bins input4_Highest_positive = {8'b01111111};
            bins input4_all_zeros={8'b0};
            bins input4_neg = {[$:-1]};
            bins input4_pos = {[1:$]};
            bins random_data=default;
        }
        input5_case: coverpoint item.input5 iff (item.rst_n) {
            bins input5_Lowest_negative = {8'b10000000};
            bins input5_Highest_positive = {8'b01111111};
            bins input5_all_zeros={8'b0};
            bins input5_neg = {[$:-1]};
            bins input5_pos = {[1:$]};
            bins random_data=default;
        }
        input6_case: coverpoint item.input6 iff (item.rst_n) {
            bins input6_Lowest_negative = {8'b10000000};
            bins input6_Highest_positive = {8'b01111111};
            bins input6_all_zeros={8'b0};
            bins input6_neg = {[$:-1]};
            bins input6_pos = {[1:$]};
            bins random_data=default;
        }
        input7_case: coverpoint item.input7 iff (item.rst_n) {
            bins input7_Lowest_negative = {8'b10000000};
            bins input7_Highest_positive = {8'b01111111};
            bins input7_all_zeros={8'b0};
            bins input7_neg = {[$:-1]};
            bins input7_pos = {[1:$]};
            bins random_data=default;
        }
        //Cross Coverage
        cross input0_case, input1_case, input2_case, input3_case,input4_case, input5_case, input6_case, input7_case ;

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
    //item = my_seq_item::type_id::create("item");
    $cast(item,t);
    Design_signals.sample();
    $display("Final Coverage --------------------> %0.2f%%",Design_signals.get_coverage());
    endfunction: write
 endclass 
