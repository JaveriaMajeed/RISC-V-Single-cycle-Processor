module tb_ ();
  reg clk = 0;
  reg reset = 1;
  
  wire memWrite_out, result_src_out, alu_src_out, regWrite_out, pc_src_out;
  wire [2:0] alu_control_out;
  wire [1:0] imm_src_out, alu_op_out;
  wire [31:0] pc_out, instruction_out, imm_out, read_data1, read_data2, alu_result, read_data_dm, mux2_out;
  wire [4:0] rs1,rs2;
  
  risc5 processor(
  .clk(clk),
  .reset(reset), 
  .pc_out(pc_out), 
  .instruction_out(instruction_out), 
  .imm_out (imm_out),
  .read_data1(read_data1), 
  .read_data2(read_data2), 
  .alu_result(alu_result),
  .read_data_dm(read_data_dm), 
  .mux2_out(mux2_out), 
  .memWrite_out(memWrite_out), 
  .imm_src_out(imm_src_out),
  .alu_src_out(alu_src_out), 
  .alu_op_out (alu_op_out),
  .alu_control_out(alu_control_out), 
  .result_src_out (result_src_out), 
  .regWrite_out (regWrite_out), 
  .pc_src_out(pc_src_out),
  .rs1(rs1),
  .rs2(rs2)
  );
  
  always #50 clk = ~clk;
  initial begin
    #100 reset = 0;
    #1000 $finish;
  end
endmodule
  