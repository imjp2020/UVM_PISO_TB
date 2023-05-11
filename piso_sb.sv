class piso_sb extends uvm_scoreboard;
  
   uvm_analysis_imp #(piso_item, piso_sb) item_collect_export;
   piso_item item_q[$];
//   piso_item exp_item;
    byte check_q[$];
    bit [7:0] mem_data[7:0];
  

    piso_item sb_pkt;


    //TLM FIFO Method
   // uvm_get_port#(piso_item) sb_in=new("sb_in",this);
     
   //TLM FIFO Method2 -Connection working fine only issue with cmpare 
   uvm_tlm_analysis_fifo#(piso_item) my_fifo;
  
 `uvm_component_utils(piso_sb)
   
  function new(string name = "piso_sb", uvm_component parent = null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export", this);
    my_fifo =new("my_fifo",this); 
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(piso_item req);
     item_q.push_back(req);
   // `uvm_info(get_type_name, $sformatf("Scoreboard transaction.data_out =%b",req.data_out), UVM_LOW);
   // `uvm_info(get_type_name, $sformatf("Scoreboard transaction.data_in =%b",req.data_in), UVM_LOW);
   // `uvm_info(get_type_name, $sformatf("Scoreboard transaction.load =%b",req.load), UVM_LOW);
  endfunction
 
task run_phase (uvm_phase phase);
   
   piso_item q[$];
   piso_item exp_pkt;
   piso_item  dut_data_out;
   static bit[31:0] temp_data_in;
   bit dout;
   int i=0; 
 
   forever
     begin  
         my_fifo.get_peek_export.get(sb_pkt);
         $cast(exp_pkt,sb_pkt.clone());
         q.push_back(exp_pkt);

         dut_data_out= q.pop_front();
       // `uvm_info(get_type_name, $sformatf("JAYESH: Scoreboard  dut_data_out.data_out     =%b",dut_data_out.data_out), UVM_LOW);
      
        
         dout=dut_data_out.data_out; 
    
        if(dut_data_out.load) begin
        temp_data_in=dut_data_out.data_in;
        i=0;
        `uvm_info(get_type_name, $sformatf("PRINTS : DATA_IN=%b load=%b ",temp_data_in,dut_data_out.load), UVM_LOW);
        end


        if(!dut_data_out.load) begin
        if(i==0) begin
        //#1;
          dout=dut_data_out.data_out;
        end
      
       // for(int i=0;i<32;i++) begin
             if(temp_data_in[i]==dout) begin
                 `uvm_info(get_type_name, $sformatf("MATCH COMPARE : DATA_IN[%0d] =%b DATA_OUT=%b dut_data_out.load=%b ",i,temp_data_in[i],dout,dut_data_out.load), UVM_LOW);
                end
                else begin
                `uvm_error("DATA MATCH ", $sformatf("COMPARE : DATA_IN[%0d] =%b DATA_OUT=%b ",i,temp_data_in[i],dout))
                end
                i++;
                if(i==32)
                      i=0;


      end
        //#2 ;
      end
endtask
 

//JAPA     task run_phase (uvm_phase phase);
//JAPA        piso_item actual_data;
//JAPA   
//JAPA   static     bit [31:0] exp_data;
//JAPA              bit actual_data_out;
//JAPA        
//JAPA        forever  
//JAPA           begin
//JAPA                wait(item_q.size > 0)
//JAPA                actual_data=item_q.pop_front();
//JAPA                //$cast(exp_data,actual_data.clone());
//JAPA               
//JAPA               if(actual_data.load) begin   // data_in                
//JAPA                   exp_data=actual_data.data_in;
//JAPA                   `uvm_info(get_type_name, $sformatf("COMPARE   Load=%b exp_data =%b ",actual_data.load,exp_data), UVM_LOW);
//JAPA                   //`uvm_info(get_type_name, $sformatf("COMPARE  ACTUAL Load=%b  data_in =%b  data_out=%b",actual_data.load,actual_data.data_in,exp_data), UVM_LOW);
//JAPA                  end
//JAPA   
//JAPA                  else  begin 
//JAPA                       actual_data_out=actual_data.data_out;
//JAPA                       `uvm_info(get_type_name, $sformatf("COMPARE  Load=%b  actual_data_out=%b ",actual_data.load,actual_data_out), UVM_LOW);
//JAPA                     // `uvm_info(get_type_name, $sformatf("compare actual_data.load=%b actual_data data_out =%b  bit=%0d temp_data_in=%b",actual_data.load,actual_data.data_out,i,temp_data_in[i]), UVM_LOW);
//JAPA               end
//JAPA                //actual_data.print();
//JAPA                //exp_data.print();
//JAPA                //`uvm_info(get_type_name, $sformatf("compare  actual_data data_out =%b  temp_data_out=%b",actual_data.data_out,temp_data_out), UVM_LOW);
//JAPA                //`uvm_info(get_type_name, $sformatf("compare  actual_data  data_in =%b  temp_data_in=%b",actual_data.data_in,temp_data_in), UVM_LOW);
//JAPA                //`uvm_info(get_type_name, $sformatf("compare actual_data.load =%b",actual_data.load), UVM_LOW);
//JAPA              
//JAPA                // Checking comparing logic
//JAPA                // begin 
//JAPA               
//JAPA                   if(exp_data!=actual_data_out) begin
//JAPA                    //`uvm_info("COMPARE","data_in MisMatch",UVM_LOW)
//JAPA                    //`uvm_info(get_type_name, $sformatf("exp_data=%b  actual_data_out=%b",exp_data,actual_data_out), UVM_LOW);
//JAPA                    //`uvm_error("COMPARE","data_out Mismatch")
//JAPA                    end
//JAPA                else begin
//JAPA                    //`uvm_info("COMPARE","data Match",UVM_LOW)
//JAPA                    //`uvm_info(get_type_name, $sformatf("exp_data=%b  actual_data_out=%b",exp_data,actual_data_out), UVM_LOW);
//JAPA                                   end
//JAPA           end 
//JAPA     endtask


//JAPA   task run_phase (uvm_phase phase);
//JAPA     seq_item sb_item;
//JAPA     forever begin
//JAPA       wait(item_q.size > 0);
//JAPA       
//JAPA       if(item_q.size > 0) begin
//JAPA         sb_item = item_q.pop_front();
//JAPA         $display("----------------------------------------------------------------------------------------------------------");
//JAPA         if(sb_item.ip1 + sb_item.ip2 == sb_item.out) begin
//JAPA           `uvm_info(get_type_name, $sformatf("Matched: ip1 = %0d, ip2 = %0d, out = %0d", sb_item.ip1, sb_item.ip2, sb_item.out),UVM_LOW);
//JAPA         end
//JAPA         else begin
//JAPA           `uvm_error(get_name, $sformatf("NOT matched: ip1 = %0d, ip2 = %0d, out = %0d", sb_item.ip1, sb_item.ip2, sb_item.out));
//JAPA         end
//JAPA         $display("----------------------------------------------------------------------------------------------------------");
//JAPA       end
//JAPA     end
//JAPA   endtask
endclass
