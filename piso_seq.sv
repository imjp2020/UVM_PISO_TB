//------------------------------------------------------------------------------
//
// SEQUENCE: base yapp sequence - base sequence with objections from which 
// all sequences can be derived
//
//------------------------------------------------------------------------------
class piso_base_seq extends uvm_sequence #(piso_item);
  
  // Required macro for sequences automation
  `uvm_object_utils(piso_base_seq)

  // Constructor
  function new(string name="piso_base_seq");
    super.new(name);
  endfunction

//japa   task pre_body();
//japa     uvm_phase phase;
//japa     `ifdef UVM_VERSION_1_2
//japa       // in UVM1.2, get starting phase from method
//japa       phase = get_starting_phase();
//japa     `else
//japa       phase = starting_phase;
//japa     `endif
//japa     if (phase != null) begin
//japa       phase.raise_objection(this, get_type_name());
//japa       `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
//japa     end
//japa   endtask : pre_body
//japa 
//japa   task post_body();
//japa     uvm_phase phase;
//japa     `ifdef UVM_VERSION_1_2
//japa       // in UVM1.2, get starting phase from method
//japa       phase = get_starting_phase();
//japa     `else
//japa       phase = starting_phase;
//japa     `endif
//japa     if (phase != null) begin
//japa       phase.drop_objection(this, get_type_name());
//japa       `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
//japa     end
//japa   endtask : post_body

endclass : piso_base_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: yapp_5_packets
//
//  Configuration setting for this sequence
//    - update <path> to be hierarchial path to sequencer 
//
//  uvm_config_wrapper::set(this, "<path>.run_phase",
//                                 "default_sequence",
//                                 my_seq::get_type());
//

//------------------------------------------------------------------------------
class my_seq extends piso_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(my_seq)

  // Constructor
  function new(string name="my_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    begin
    `uvm_info(get_type_name(), "my_seq sequence start", UVM_LOW)
        #50;
       `uvm_do_with(req,{load==0;})
        #2;
       `uvm_do_with(req,{load==0;})
        #2;
       `uvm_do_with(req,{load==0;})
        #2;
       `uvm_do_with(req,{load==0;})
        #2;
       `uvm_do_with(req,{load==0;})
        #2;
       `uvm_do_with(req,{load==0;})
        #2;
       `uvm_do_with(req,{load==0;})
        #2;
        
       req.print();
    `uvm_info(get_type_name(), "my_seq sequence done", UVM_LOW)
    end
  endtask
  
endclass : my_seq

class load_seq extends piso_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(load_seq)

  // Constructor
  function new(string name="load_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
  // repeat(3)
    begin
    `uvm_info(get_type_name(), "Load_seq sequence start", UVM_LOW)
      //`uvm_do(req)
     // for(int i=0; i< 5 ; i++)  
         //`uvm_do_with(req,{load==i+1;})
          #200;
         `uvm_do_with(req,{load==1;data_in=='d10;})
          #2;
         `uvm_do_with(req,{load==1;data_in=='d15;})
          #2;
         `uvm_do_with(req,{load==1;data_in=='d8;})
          #2;
    `uvm_info(get_type_name(), "Load_seq sequence done", UVM_LOW)
    end
  endtask
  
endclass : load_seq 



class loadoff extends piso_base_seq;
 


   load_seq    seq1_h;
   my_seq      seq2_h;
  // Required macro for sequences automation
  `uvm_object_utils(loadoff)

  // Constructor
  function new(string name="loadoff");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
       
    `uvm_info(get_type_name(), "Executing loadoff sequence start", UVM_LOW)
         
          `uvm_do_with(req,{load==1;data_in=='d5;})
          #1;
         `uvm_do_with(req,{load==0;})
          #31;
          `uvm_do_with(req,{load==1;data_in=='d10;})
          #1;
         `uvm_do_with(req,{load==0;})
          #31;
          `uvm_do_with(req,{load==1;data_in=='d9;})
          #1;
         `uvm_do_with(req,{load==0;})
          #31;

   //   `uvm_do(seq1_h)
   //   `uvm_do(seq2_h)
     `uvm_info(get_type_name(), "Executing loadoff sequence done", UVM_LOW)
  endtask
  
endclass : loadoff            

//  japa   
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: yapp_012_seq - send random packets to channel 0, 1, 2 in order
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   class yapp_012_seq extends piso_base_seq;
//  japa     
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(yapp_012_seq)
//  japa   
//  japa     // Constructor
//  japa     function new(string name="yapp_012_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       `uvm_info(get_type_name(), "Executing YAPP_012_SEQ started...", UVM_LOW)
//  japa       `uvm_do_with(req, {req.addr == 2'b00;})
//  japa       `uvm_do_with(req, {req.addr == 2'b01;})
//  japa       `uvm_do_with(req, {req.addr == 2'b10;})
//  japa       `uvm_info(get_type_name(), "Executing YAPP_012_SEQ ended...", UVM_LOW)
//  japa     endtask
//  japa     
//  japa   endclass : yapp_012_seq
//  japa   
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: yapp_1_seq - send a random packet to Channel 1
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   class yapp_1_seq extends piso_base_seq;
//  japa     
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(yapp_1_seq)
//  japa   
//  japa     // Constructor
//  japa     function new(string name="yapp_1_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       `uvm_info(get_type_name(), "Executing YAPP_1_SEQ started...", UVM_LOW)
//  japa       `uvm_do_with(req, {req.addr == 2'b01;})
//  japa       `uvm_info(get_type_name(), "Executing YAPP_1_SEQ ended", UVM_LOW)
//  japa     endtask
//  japa     
//  japa   endclass : yapp_1_seq
//  japa   
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: yapp_111_seq - send three random packets to channel 1
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   class yapp_111_seq extends piso_base_seq;
//  japa     
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(yapp_111_seq)
//  japa   
//  japa     // Nested Sequence - executes yapp_1_seq three times
//  japa     yapp_1_seq addr_1_seq;
//  japa   
//  japa     // Constructor
//  japa     function new(string name="yapp_111_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       `uvm_info(get_type_name(), "Executing YAPP_111_SEQ started...", UVM_LOW)
//  japa       repeat (3) 
//  japa         `uvm_do(addr_1_seq)
//  japa       `uvm_info(get_type_name(), "Executing YAPP_111_SEQ ended...", UVM_LOW)
//  japa   
//  japa     endtask
//  japa     
//  japa   endclass : yapp_111_seq
//  japa   
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: yapp_repeat_addr_seq - sends two packets to the same random address
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   class yapp_repeat_addr_seq extends piso_base_seq;
//  japa     
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(yapp_repeat_addr_seq)
//  japa   
//  japa     // Constructor
//  japa     function new(string name="yapp_repeat_addr_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // rand sequence property
//  japa     rand bit [1:0] seqaddr;
//  japa     constraint legal_addr {seqaddr != 3;}
//  japa   
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       `uvm_info(get_type_name(), "Executing REPEAT_ADDR_SEQ", UVM_LOW)
//  japa       repeat (2) 
//  japa         `uvm_do_with(req, {req.addr == seqaddr;})
//  japa   //  alternative
//  japa   //  `uvm_do(req);
//  japa   //  seqaddr = req.addr;
//  japa   //  `uvm_do_with(req, {req.addr == seqaddr;})
//  japa     endtask
//  japa   
//  japa   endclass : yapp_repeat_addr_seq
//  japa   
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: yapp_incr_payload_seq - sends single packet with incrementing payload
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   class yapp_incr_payload_seq extends piso_base_seq;
//  japa     
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(yapp_incr_payload_seq)
//  japa   
//  japa     // Constructor
//  japa     function new(string name="yapp_incr_payload_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       int ok;
//  japa       `uvm_info(get_type_name(), "Executing YAPP_INCR_PAYLOAD_SEQ", UVM_LOW)
//  japa       // simple solution using constraint
//  japa       //`uvm_do_with(req, {foreach (payload[i]) payload[i] == i ; })
//  japa       // intended solution using create and send macros
//  japa       `uvm_create(req)
//  japa       ok = req.randomize();
//  japa       foreach (req.payload [i])
//  japa         req.payload[i] = i;
//  japa       req.set_parity();  // recalculate parity taking into account parity_type
//  japa       `uvm_send(req)     // send without further randomization
//  japa     endtask
//  japa   endclass : yapp_incr_payload_seq
//  japa     
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: yapp_rnd_seq
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   
//  japa   class yapp_rnd_seq extends piso_base_seq;
//  japa   
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(yapp_rnd_seq)
//  japa   
//  japa     // Parameter for this sequence
//  japa     rand int count;
//  japa   
//  japa     // Sequence Constraints
//  japa     constraint count_limit { count inside {[1:10]}; }
//  japa   
//  japa     // Constructor
//  japa     function new(string name="yapp_rnd_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       `uvm_info(get_type_name(), $sformatf("Executing YAPP_RND_SEQ %0d times...", count), UVM_LOW)
//  japa       repeat (count) begin
//  japa         `uvm_do(req)
//  japa       end
//  japa     endtask
//  japa   
//  japa   endclass : yapp_rnd_seq
//  japa   
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: six_yapp_seq
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   
//  japa   class six_yapp_seq extends piso_base_seq;
//  japa   
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(six_yapp_seq)
//  japa   
//  japa     // Parameter for this sequence
//  japa     yapp_rnd_seq yss;
//  japa   
//  japa     // Constructor
//  japa     function new(string name="six_yapp_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       `uvm_info(get_type_name(), "Executing SIX_YAPP_SEQ" , UVM_LOW)
//  japa       `uvm_do_with(yss, {count==6;})
//  japa     endtask
//  japa   
//  japa   endclass : six_yapp_seq
//  japa   
//  japa   //------------------------------------------------------------------------------
//  japa   //
//  japa   // SEQUENCE: yapp_exhaustive_seq
//  japa   //
//  japa   //------------------------------------------------------------------------------
//  japa   
//  japa   class yapp_exhaustive_seq extends piso_base_seq;
//  japa   
//  japa     // Required macro for sequences automation
//  japa     `uvm_object_utils(yapp_exhaustive_seq)
//  japa   
//  japa     // handles for all lab05 sequences - use meaningful handles for debug!
//  japa     yapp_012_seq y012;
//  japa     yapp_1_seq y1;
//  japa     yapp_111_seq y111;
//  japa     yapp_repeat_addr_seq yaddr;
//  japa     yapp_incr_payload_seq yinc;
//  japa     //six_yapp_seq ysix;
//  japa   
//  japa     // Constructor
//  japa     function new(string name="yapp_exhaustive_seq");
//  japa       super.new(name);
//  japa     endfunction
//  japa   
//  japa     // Sequence body definition
//  japa     virtual task body();
//  japa       `uvm_info(get_type_name(), "Executing YAPP_EXHAUSTIVE_SEQ" , UVM_LOW)
//  japa   //    `uvm_do(y012)
//  japa   //     `uvm_do(y1)
//  japa           `uvm_do(y111)
//  japa   //    `uvm_do(yaddr)
//  japa   //    `uvm_do(yinc)
//  japa      // `uvm_do(ysix)
//  japa     endtask
//  japa   
//  japa   endclass : yapp_exhaustive_seq



