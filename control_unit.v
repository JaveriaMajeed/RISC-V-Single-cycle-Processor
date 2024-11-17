module control_unit (opcode, branch, imm_src, result_src, alu_op,
 memWrite, alu_src, regWrite, pc_src);
  input [6:0] opcode;
  output reg branch, result_src, memWrite, alu_src, regWrite, pc_src;
  output reg [1:0] imm_src, alu_op;
  
  always @ (*)
  case(opcode)
    7'b0000011 : // lw
    begin
      alu_src<=1;
      result_src<=1;
      imm_src<= 2'b00;
      regWrite<=1;
      memWrite<= 0;
      branch <= 0;
      alu_op <= 00;
      pc_src <= 0;
    end
    7'b0100011 :  //sw
    begin
      alu_src<=1;
      result_src<=1'bx;
      imm_src<= 2'b01;
      regWrite<=0;
      memWrite<= 1;
      branch <= 0;
      alu_op <= 00;
      pc_src <= 0;
    end
    7'b0010011 :  //addi
    begin
      alu_src<=1;
      result_src<=0;
      imm_src<= 2'b00;
      regWrite<=1;
      memWrite<= 0;
      branch <= 0;
      alu_op <= 10;
      pc_src <= 0;
    end
    7'b1100011 :  // branch
    begin
      alu_src<=0;
      result_src<=1'bx;
      imm_src<= 2'b10;
      regWrite<=0;
      memWrite<= 0;
      branch <= 1;
      alu_op <= 01;
      pc_src <= 1;
    end
    7'b0110011 : //R type
    begin
      alu_src<=0;
      result_src<=0;
      imm_src<= 2'bxx;
      regWrite<=1;
      memWrite<= 0;
      branch <= 0;
      alu_op <= 10;
      pc_src <= 0;
    end
      
  endcase
endmodule



module tb_control_unit;
  reg [6:0] opcode;
  wire branch, result_src, memWrite, alu_src, regWrite, pc_src;
  wire [1:0] imm_src, alu_op;

  // Instantiate the control_unit module
  control_unit uut (.opcode(opcode),.branch(branch),.result_src(result_src),.memWrite(memWrite),
    .alu_src(alu_src),.regWrite(regWrite),.pc_src(pc_src),.imm_src(imm_src),.alu_op(alu_op)
  );

  // Stimulus generation
  initial begin
    opcode = 7'b0000011; //lw
    #10 opcode = 7'b0100011;  //sw
    #10 opcode = 7'b0010011;  // addi
    #10 opcode = 7'b1100011;  // beq
    #10 opcode = 7'b0110011;  // r type
    $finish;
  end
endmodule

      
    
