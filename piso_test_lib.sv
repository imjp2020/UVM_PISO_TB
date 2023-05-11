//------------------------------------------------------------------------------
//
// CLASS: test_lib
//
//------------------------------------------------------------------------------

class piso_base_test extends uvm_test;



  protected int def_file ;
  protected int warn_file;
  protected int my_id_file;
  protected int COMP1_file;


  // component macro
  `uvm_component_utils(piso_base_test)

//  router_tb tb;
     piso_env    env;
  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM build_phase()
  function void build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"build_phase", get_full_name()}, UVM_HIGH) 
    super.build_phase(phase);
    uvm_config_int::set( this, "*", "recording_detail", 1);
    env = piso_env::type_id::create("env", this);
    //tb = router_tb::type_id::create("tb", this);
  endfunction : build_phase
  
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  // start_of_simulation added for lab03
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH);
    def_file     = $fopen("def_file", "w");
    warn_file    = $fopen("warn_file", "w");
    my_id_file   = $fopen("my_id_file","w");
    COMP1_file   = $fopen("COMP1_file", "w");

    set_report_severity_action_hier(UVM_INFO, UVM_DISPLAY | UVM_LOG);
    set_report_severity_action_hier(UVM_WARNING, UVM_DISPLAY | UVM_LOG);
    set_report_severity_action_hier(UVM_ERROR, UVM_DISPLAY | UVM_COUNT | UVM_LOG);
    set_report_severity_action_hier(UVM_FATAL, UVM_DISPLAY | UVM_EXIT | UVM_LOG);

    // all messages from this hierarchy will go to def_file.
  // messages from COMP1 will not show up because
  // we have set another set_report_default_file option for it.
  set_report_default_file_hier(def_file);
  // all messages from COMP1 will go to COMP1_file
   //piso_driver.set_report_default_file(COMP1_file);


    // all warning from this hierarchy will go to warn_file
   set_report_severity_file_hier(UVM_WARNING, warn_file);

    //To log messages with a specific ID to a separate file, use the set_report_id_file method.

  //all messages from uvm_test_top.COMP1 with id "my_id" will go to my_id_file
  //uvm_test_top.env.set_report_id_file("my_id", my_id_file);
  
endfunction: start_of_simulation_phase


  function void check_phase(uvm_phase phase);
    // configuration checker
    check_config_usage();
  endfunction

endclass : piso_base_test

//------------------------------------
//test2           
//------------------------------------

class test2 extends piso_base_test;

  // component macro
  `uvm_component_utils(test2)

    loadoff loadoff_seq_h;  

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //uvm_config_wrapper::set(this, "uvm_test_top.env.agent.sequencer.run_phase",
    //                               "default_sequence",
    //                               my_seq::get_type());
    //seq_h=my_seq::type_id::create("seq_h",this);                              
  endfunction : build_phase


     //run_phase task()
  task run_phase(uvm_phase phase);
    super.run_phase(phase);     
     
  `uvm_info("test2","RUN_PHASE ON",UVM_LOW)
  
  phase.raise_objection(this, "Raise Objection"); 
  
  loadoff_seq_h=loadoff::type_id::create("loadoff_seq_h",this);                              
    //forever           
      //     begin
              //loadoff_seq_h.start(null);//env.agent.sequencer);
              loadoff_seq_h.start(env.agent.sequencer);
             //#10;
        //   end
     
     phase.drop_objection(this, "Drop Objection");
     `uvm_info("fifo_test","RUN_PHASE OFF",UVM_LOW)
   endtask 
    
endclass : test2
