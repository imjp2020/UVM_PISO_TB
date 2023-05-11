
module piso_tb_top;

  // import the UVM library
  import uvm_pkg::*;

  // include the UVM macros
  `include "uvm_macros.svh"

  // import the PISO UVC package
  import piso_pkg::*;

  // include the psio env - testbench file
  `include "piso_env.sv"

  // include the test_lib.sv file
  `include "piso_test_lib.sv"

  initial begin
    piso_vif_config::set(null,"*","vif",piso_hw_top.in0);
    run_test();
  end

endmodule
