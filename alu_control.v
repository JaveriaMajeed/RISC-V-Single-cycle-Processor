module alu_control(alu_op, func3,func7,op5, alu_control);
input [2:0] func3;
input func7,op5;
input [1:0] alu_op;
output reg [2:0] alu_control;

always @(*)
begin
case(alu_op)
	2'b00: alu_control=000;
	2'b01: alu_control=001;
	2'b10:
		case(func3)
			3'b000: 
			    case({op5,func7})
				2'b00 : alu_control=000; //add
		    2'b01 : alu_control=000;  // add
				2'b10: alu_control=000;  // add 
				2'b11: alu_control=001;  //sub
        default: alu_control=3'bxxx; 
			    endcase  
			3'b010: alu_control=101; //sli
			3'b110: alu_control=011;  //or
			3'b111: alu_control=010;  //and
			default: alu_control=3'bxxx;
		endcase
endcase
end
endmodule

module tb_alu_control;
  reg [2:0] func3; reg func7, op5;
  reg [1:0] alu_op; wire [2:0] alu_control;

  // Instantiate the alu_control module
  alu_control uut (.func3(func3), .func7(func7),.op5(op5),.alu_op(alu_op),
    .alu_control(alu_control)
  );

  // Stimulus generation
  initial begin
    alu_op = 2'b00; //case 1
    func3 = 3'b000;
    func7 = 0;
    op5 = 0;

    #10 alu_op = 2'b01;  //case 2
    func3 = 3'b010;
    func7 = 0;
    op5 = 0;
    
    #10 alu_op = 2'b10;  //case 3
    func3 = 3'b110;
    func7 = 1;
    op5 = 1;

    #10 alu_op = 2'b10;  // case 4
    func3 = 3'b111;
    func7 = 1;
    op5 = 1;
    
    $finish;
  end
endmodule
