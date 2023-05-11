//------------------------------------------------------------
//   PISO interface 
//------------------------------------------------------------

interface  piso_if(input bit clk,rst);

logic load ;
logic [31:0]  data_in;
logic  data_out;

task print();
  $display("PISO vif executed...");
endtask

endinterface 

//property p1;
//     @(posedge clk) (load) |=> $isuknown(data_out);
//endproperty

//LOAD:assert property(p1);
//module piso (input load, clk, rst,
//             input [31:0] data_in,
//             output reg data_out);
  
  
