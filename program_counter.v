module program_counter (clk, reset, pc_in, pc_out);
  input clk,reset;
  input [31:0] pc_in;
  output reg [31:0] pc_out;
  
  always @ (posedge clk)
  begin
    if (reset == 1'b0)
      pc_out <= 32'h00000000;
    else
      pc_out <= pc_in;
    end
  endmodule
  
  
 