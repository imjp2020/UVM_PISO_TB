/*-----------------------------------------------------------------
File name     : hw_top_dut.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : lab06_vif hardware top module for acceleration
              : instantiates clock generator, interfaces and DUT
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module piso_hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;
  logic         clk=0; 
  logic         rst=0;


  always #10 clk  = ~clk;
 
  // YAPP Interface to the DUT
  piso_if in0(clk,rst);



  // CLKGEN module generates clock
  clkgen clkgen (
    .clock(clock ),
    .run_clock(1'b1),
    .clock_period(32'd10)
  );



  piso DUT (.load(in0.load),
            .clk(in0.clk),
             .rst(in0.rst),
             .data_in(in0.data_in),
             .data_out(in0.data_out)
          );

//  yapp_router dut(
//    .reset(reset),
//    .clock(clock),
//    .error(),
//    // YAPP interface signals connection
//    .in_data(in0.in_data),
//    .in_data_vld(in0.in_data_vld),
//    .in_suspend(in0.in_suspend),
//    // Output Channels
//    //Channel 0   
//    .data_0(),
//    .data_vld_0(),
//    .suspend_0(1'b0),
//    //Channel 1   
//    .data_1(),
//    .data_vld_1(),
//    .suspend_1(1'b0),
//    //Channel 2   
//    .data_2(),  
//    .data_vld_2(),
//    .suspend_2(1'b0),
//    // Host Interface Signals
//    .haddr(),
//    .hdata(),
//    .hen(),
//    .hwr_rd());



 initial 
  begin
    #1000 $finish();
     end

endmodule

