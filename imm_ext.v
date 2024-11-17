module imm_ext(instruction, imm_src, imm_data);
  input [1:0] imm_src;
  input [31:0] instruction;
  output reg [31:0] imm_data;
  
  always @(instruction, imm_src)
  begin
    case (imm_src)
      2'b00: imm_data = {{20{instruction[31]}}, instruction[31:20]};
      2'b01: imm_data = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
      2'b10: imm_data = {{20{instruction[31]}}, instruction[7], instruction[31:25], instruction[11:8]};
    endcase
  end
endmodule

// Test bench

module tb_imm();
  reg [1:0] imm_src;
  reg [31:0] instruction;
  wire [31:0] imm_data;
  
  imm_ext imm(.imm_src(imm_src), .instruction(instruction),.imm_data(imm_data));
  
  initial begin
    // Test Case 1
    imm_src = 2'b00;
    instruction = 32'h12345678;
    #10;

    // Test Case 2
    imm_src = 2'b01;
    instruction = 32'h87654321;
    #10;

    // Test Case 3
    imm_src = 2'b10;
    instruction = 32'hABCDEF01;
    #10;

    // Finish simulation
    $finish;
  end
endmodule
    