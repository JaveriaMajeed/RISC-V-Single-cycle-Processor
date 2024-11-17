module branch_adder (pc_out,imm, pc_target );
  input [31:0] pc_out, imm;
  output [31:0] pc_target;
  
  assign pc_target = pc_out + imm;
  
  endmodule 
