
//------------------------------------------------------------------------------
//  piso_driver
//------------------------------------------------------------------------------

// using type parameterized driver which defines built-in piso_item handle req 
class piso_driver extends uvm_driver #(piso_item);

  // Declare this property to count packets sent
  int num_sent;

  virtual interface piso_if vif;
  
  

  // component macro
  `uvm_component_utils_begin(piso_driver)
    `uvm_field_int(num_sent, UVM_ALL_ON)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new


  function void build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"build_phase", get_full_name()}, UVM_HIGH) 
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    //if (!piso_vif_config::get(this,"","vif", vif))
    if(!uvm_config_db#(virtual piso_if)::get(this,"*","vif",vif))
      `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
    `uvm_info(get_type_name(), "DEBUG MSG1-vif", UVM_HIGH)
  endfunction: connect_phase

  // start_of_simulation 
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH) 
  endfunction : start_of_simulation_phase

  // UVM run_phase
  task run_phase(uvm_phase phase);
    fork
      get_and_drive();
     // reset_signals();
           
    join
   
  endtask : run_phase

  // Gets packets from the sequencer and passes them to the driver. 
  task get_and_drive();
     `uvm_info(get_type_name(), "DEBUG MSG1", UVM_HIGH)
    forever
      begin
    `uvm_info(get_type_name(), "Driver get and drive started", UVM_HIGH)
      // Get new item from the sequencer
      seq_item_port.get_next_item(req);
      data_drive(req);
      // End transaction recording
      end_tr(req);
      num_sent++;
      // Communicate item done to the sequencer
      seq_item_port.item_done();
     `uvm_info(get_type_name(), "Driver get and drive ended", UVM_HIGH)
    end
    `uvm_info(get_type_name(), "DEBUG MSG2", UVM_HIGH)
  endtask : get_and_drive

  // Drive PISO dut via if and req
 protected task data_drive(piso_item req);
 begin
    if(!vif.rst)
     begin
        `uvm_info(get_type_name(), "drive stimulus started()", UVM_HIGH)
        `uvm_info(get_type_name(), "RESET Asserted()", UVM_HIGH)
         vif.load<=0;
         vif.data_in<=0;
         vif.data_out<=0;
        `uvm_info(get_type_name(), "RESET De-Asserted()", UVM_HIGH)
     end
    else begin
         @(posedge vif.clk)
         begin
         vif.load<=req.load;
         vif.data_in<=req.data_in;
         `uvm_info(get_type_name(), $sformatf("data_in=%b",vif.data_in), UVM_HIGH)
         `uvm_info(get_type_name(), $sformatf("data_out=%b",vif.data_out), UVM_HIGH)
         `uvm_info(get_type_name(), $sformatf("load   =%b",vif.load), UVM_HIGH)
         end
         end  
         
  `uvm_info(get_type_name(), "drive stimulus ended()", UVM_HIGH)
   end 
  endtask

  // Reset all TX signals
  task reset_signals();
    //forever 
    // vif.reset_piso();
  endtask : reset_signals

  // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: PISO diver sent %0d data_in", num_sent), UVM_HIGH)
  endfunction : report_phase

endclass : piso_driver

