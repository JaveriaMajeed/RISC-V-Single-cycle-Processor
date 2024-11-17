module register_file (clk,rs1,rs2,rd,write_data,reg_write,read_data1,read_data2);
  input clk,reg_write;
  input [4:0] rs1, rs2,rd ;
  input [31:0] write_data;
  output [31:0] read_data1,read_data2;
  
  reg [31:0] register [31:0];
  integer k;
  
  assign read_data1 = register[rs1];
  assign read_data2 = register[rs2];
  

  initial
  begin
    for (k=0; k<32; k = k+1)
    register[k] = k;
  end

  always @(posedge clk)
  begin
    if (reg_write)
      register[rd] = write_data;
    end
  endmodule
  
module tb_register_file;
  reg clk = 1; 
  reg reg_write;
  reg [4:0] rs1, rs2, rd;
  reg [31:0] write_data;
  wire [31:0] read_data1, read_data2;

  // Instantiate the register_file module
  register_file uut(.clk(clk),.rs1(rs1), .rs2(rs2), .rd(rd), .write_data(write_data), .reg_write(reg_write),
  .read_data1(read_data1), .read_data2(read_data2));

  // Clock generation
  always #5 clk = ~clk;
  // Stimulus generation
  initial begin
    // Test Case 1
    reg_write = 1;
    rs1 = 5;
    rs2 = 10;
    rd = 15;
    write_data = 42;
    #10;

    // Test Case 2
    reg_write = 1;
    rs1 = 8;
    rs2 = 4;
    rd = 12;
    write_data = 100;
    #10;

    // Test Case 3
    reg_write = 0;
    rs1 = 2;
    rs2 = 6;
    rd = 18;
    #10;

    // Finish simulation
    $finish;
  end
endmodule
