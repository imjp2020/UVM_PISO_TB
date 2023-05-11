//------------------------------------------------------------------------------
//
// CLASS: piso_env
//
//------------------------------------------------------------------------------

class piso_env extends uvm_env;

  // Components of the environment
  piso_agent agent;
  piso_sb    sb;


  //TLM FIFO Method
  uvm_tlm_fifo#(piso_item) my_fifo;
  // component macro
  `uvm_component_utils(piso_env)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM build_phase()
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     agent = new("agent", this);
     my_fifo =new("my_fifo",this,100);
     sb=piso_sb::type_id::create("sb",this);
    
     `uvm_info(get_type_name(), {"build_phase", get_full_name()}, UVM_HIGH) 
  endfunction : build_phase

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase
  
  // UVM connect_phase() method
  function void connect_phase(uvm_phase phase);
     
      // Connect the monitor and sb  
      agent.monitor.collect_port.connect(sb.my_fifo.analysis_export);
        //           sb.sb_in.connect(my_fifo.get_peek_export);
       //agent.monitor.collect_port.connect(sb.fifo_wrh.analysis_export);
 	   //agent.monitor.collect_port.connect(sb.fifo_rdh.analysis_export);
  endfunction : connect_phase

endclass : piso_env

