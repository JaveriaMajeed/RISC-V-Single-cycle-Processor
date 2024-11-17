module alu (A,B, alu_control, zero,alu_result);
  input [31:0] A,B;
  input [2:0] alu_control;
  output reg [31:0] alu_result;
  output zero;
  
  always @(*)
  begin
    case(alu_control)
      3'b000: alu_result <= A+B;
      3'b001: alu_result <= A-B;
      3'b010: alu_result <= A&B;
      3'b011: alu_result <= A|B;
      3'b101: alu_result <= A<B;
      default: alu_result <= 32'bxx;
    endcase
  end
  assign zero = alu_result==0?1:0;
  endmodule

module tb_alu();
  reg [31:0] A,B;
  reg [2:0] alu_control;
  wire [31:0] alu_result;
  wire zero;
  // insantitiate the module
  alu alu(.A(A), .B(B), .alu_control(alu_control), .alu_result(alu_result), .zero(zero));
  initial begin
    A= 32'h67; B = 32'hFF;
    alu_control = 3'b000;
    #10 alu_control = 3'b001;
    #10 alu_control = 3'b010;
    #10 alu_control = 3'b011;
    #10 alu_control = 3'b101;
    #10 $finish;
  end
endmodule