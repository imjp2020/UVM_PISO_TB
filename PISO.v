// -------------------------------------------------------
// Parellel Input Serial Output 
// -------------------------------------------------------
`timescale 1ns/1ns
module piso (input load, clk, rst,
             input [31:0] data_in,
             output reg data_out);
  
  // PISO register array to load and shift data
  reg [31:0] data_reg;
  
  always @ (posedge clk or negedge rst) begin
    if (~rst)
      data_reg <= 8'h00; // Reset PISO register array on reset
    else begin
      
      // Load the data to the PISO register array and reset the serial data out register
      if (load)
      	{data_reg, data_out} <= {data_in, 1'b0};
      // Shift the loaded data 1 bit right; into the serial data out register
      else
      {data_reg, data_out} <= {1'b0, data_reg[31:0]};
    end
  end
  
endmodule
