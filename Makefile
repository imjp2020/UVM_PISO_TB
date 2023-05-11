# ----------------------------------------------------------
#              This Makefile manually enerated  
#-----------------------------------------------------------

CONFIG_DIR=.
FILES = $(CONFIG_DIR)/cdns_uvmreg_utils_pkg.sv $(CONFIG_DIR)/yapp_router_regs_rdb.sv $(CONFIG_DIR)/quicktest.sv
COV_OPTS=-coverage a -covoverwrite -nowarn CGPIZE

# TB files list
piso_tb_uvm=.
L_FILES=$(piso_tb_uvm)/piso_pkg.svh   $(piso_tb_uvm)/piso_if.sv $(piso_tb_uvm)/tb_top.sv   $(piso_tb_uvm)/PISO.v  

#full tests runs 
regression:  compile  set_config_test exhaustive_seq_test short_packet_test 

run:
	make compile ; make test2
# add option for complie 
compile:
	xrun -c -sysv -uvm -compile -l compile.log -assert  -access +rwc $(L_FILES)  -timescale 1ns/1ns

# run tests target
#exhaustive_seq_test:
#	xrun -uvm -r worklib.tb_top -l exhaustive_seq_test.log  +UVM_TESTNAME=exhaustive_seq_test   +UVM_VERBOSITY=UVM_HIGH 
test2_gui:
	xrun -uvm -r worklib.tb_top -l test2.log  +UVM_TESTNAME=test2    +UVM_VERBOSITY=UVM_HIGH -access +rwc -gui 


test2:
	xrun -uvm -r worklib.tb_top -l test2.log  +UVM_TESTNAME=test2    +UVM_VERBOSITY=UVM_HIGH  -access +rwc 
	
##	+UVM_OBJECTION_TRACE 

piso_base_test:
	xrun -uvm -r worklib.tb_top -l piso_base_test.log  +UVM_TESTNAME=piso_base_test +UVM_VERBOSITY=UVM_HIGH -access +rwc -gui
	

#access_test:
##	xrun -uvm -r worklib.test -l ral_test.log  +UVM_TESTNAME=access_test  +UVM_VERBOSITY=UVM_HIGH 

done:
		echo ******************** REGRESSION RUN COMPLETED **************
		echo ******************** Clean all runs *************************

clean:
		rm -rf  xcelium.shm/ xcelium.d/ waves.shm/ xrun*.log *.log 


	

