//------------------------------------------------------------------------------
// CLASS: piso_sequencer
//------------------------------------------------------------------------------

class piso_sequencer extends uvm_sequencer #(piso_item);

  `uvm_component_utils(piso_sequencer)

  function new(string name, uvm_component parent);   
    super.new(name, parent);     // important!!
  endfunction

   function void build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"build_phase", get_full_name()}, UVM_HIGH) 
  endfunction : build_phase

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : piso_sequencer


