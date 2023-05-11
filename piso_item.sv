//------------------------------------------------------------
//   piso item
//------------------------------------------------------------

`include "uvm_macros.svh"
import uvm_pkg::*;

class piso_item extends  uvm_sequence_item;

rand   logic           load;
rand   logic  [31:0]  data_in;
       logic          data_out;
   
   //constraint load_c {  load==1     ;}
    constraint data_c{ data_in <= 64 ;}

  function new(string name = "piso_item");
      super.new(name);
  endfunction
   
  `uvm_object_utils_begin(piso_item)
    `uvm_field_int(load, UVM_ALL_ON)
    `uvm_field_int(data_in, UVM_ALL_ON)
    `uvm_field_int(data_out, UVM_ALL_ON)
  `uvm_object_utils_end

   virtual function void do_copy(uvm_object rhs);
    piso_item _pkt;
    super.do_copy(rhs);
    $cast(_pkt, rhs);
   	load = _pkt.load;
   	data_out = _pkt.data_out;
   	data_in = _pkt.data_in;
    //`uvm_info(get_name(), "In Packet::do_copy()", UVM_LOW)
  endfunction

// Need tosee UVM1.2 D compile switch 
// VCS compile clean
// function void do_print(uvm_printer printer);
//    super.do_print(printer);
//    printer.print_field_int("data_out", data_out,$bits(data_out), UVM_HEX);
//    printer.print_field_int("data_in",data_in,$bits(data_in),UVM_HEX);
//    printer.print_field_int("load",load,$bits(load),UVM_HEX);
// endfunction
  
  
    // Customizse print()
 /*  virtual function string convert2string();
    
     string msg =super.convert2string(); 
     $sformat(msg,"%s\n-------------------\n\wr\t= %0d\n ",msg,wn);
     $sformat(msg,"%srn\t= %0d\n",msg,rn);
     $sformat(msg,"%sdatain\t= %0d\n",msg,datain);
     $sformat(msg,"%sdataout\t= %0d\n",msg,dataout);
     $sformat(msg,"%sfull\t= %0d\n",msg,full);
     $sformat(msg,"%sempty\t= %0d\n---------------\n",msg,empty);
     
    return msg;
    
    endfunction
  */
  
   /*virtual function string convert2string();
     string m_data= "";
      //$sformat(m_data,"%s sop %h",m_data,sop);
     $sformat(m_data,"%s datain %h",m_data,datain);
     //foreach(data[i]) begin
     //  $sformat(m_data,"%s data %h",m_data,data[i]);
    //   end
     return m_data;
  endfunction*/
  
endclass
