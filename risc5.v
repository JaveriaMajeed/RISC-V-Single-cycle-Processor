module risc5(clk,reset, pc_out, instruction_out, imm_out,read_data1, read_data2,
alu_result,read_data_dm, mux2_out, 
memWrite_out, imm_src_out,alu_src_out, alu_op_out ,alu_control_out,
 result_src_out, regWrite_out, pc_src_out,rs1,rs2);
  
  input clk,reset;
  
  output memWrite_out, result_src_out, alu_src_out, regWrite_out, pc_src_out;
  output [2:0] alu_control_out;
  output [1:0] imm_src_out, alu_op_out;
  output [31:0]pc_out, instruction_out, imm_out, read_data1, read_data2, alu_result, read_data_dm, mux2_out;
  output [4:0] rs1,rs2;
  
  wire [31:0] mux1_out, pc_plus4_out, pc_target, mux3_out;// read_data2_op, alu_result_op;
  
  assign rs1 = instruction_out[19:15];
  assign rs2 = instruction_out[24:20];  
  
  //assign read_data2 = read_data2_op;
  //assign alu_result = alu_result_op;
  //assign memWrite = memWrite_out_op;
  
  program_counter program_counter(
  .clk (clk), 
  .reset (reset), 
  .pc_in (mux3_out), 
  .pc_out (pc_out)
  );
  
  instruction_memory instruction_memory(
  .inst_addr (pc_out), 
  .instruction (instruction_out)
  );
  
  register_file register_file(
  .clk(clk),
  .rs1(instruction_out[19:15]),
  .rs2(instruction_out[24:20]),
  .rd(instruction_out[11:7]),
  .write_data(mux2_out), 
  .reg_write(regWrite_out),
  .read_data1(read_data1),
  .read_data2(read_data2) //output
  );
  
  imm_ext imm_ext(
  .instruction (instruction_out[31:7]), 
  .imm_src (imm_src_out), 
  .imm_data (imm_out)
  );
  
  mux mux1(
  .a (imm_out),
  .b (read_data2),  
  .sel (alu_src_out),
  .c (mux1_out)
  );
  
  alu alu(
  .A (read_data1),
  .B (mux1_out),
  .alu_control (alu_control_out), 
  .zero (),
  .alu_result (alu_result) //output
  );
  
  alu_control alu_control (
  .alu_op (alu_op_out), 
  .func7 (instruction_out[29]), 
  .func3 (instruction_out[14:12]), 
  .op5 (instruction_out[4]),
  .alu_control (alu_control_out)
  );
  
  adder adder(
  .pc (pc_out), 
  .pc_plus4 (pc_plus4_out)
  );
  
  data_memory Data_Memory(
  .clk (clk),
  .mem_addr(alu_result), 
  .write_data(read_data2), 
  .memWrite(memWrie_out), 
  .read_data (read_data_dm)
  );
  
  mux Mux2(
  .a (read_data_dm),
  .b(alu_result),
  .sel(result_src_out),
  .c (mux2_out)
  );
  
  branch_adder branch_adder(
  .pc_out (pc_out),
  .imm (imm_out), 
  .pc_target(pc_target) 
  );
  
  mux Mux3(
  .a (pc_target),
  .b(pc_plus4_out),
  .sel(pc_src_out),
  .c (mux3_out)
  );
  
  control_unit control_unit(
  .opcode (instruction_out[6:0]) , 
  .branch (), 
  .imm_src (imm_src_out), 
  .result_src (result_src_out), 
  .alu_op (alu_op_out), 
  .memWrite (memWrite_out), // output
  .alu_src (alu_src_out), 
  .regWrite (regWrite_out),
  .pc_src (pc_src_out)
  );
  
endmodule