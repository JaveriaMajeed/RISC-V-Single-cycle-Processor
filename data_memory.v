module data_memory (clk,mem_addr, write_data, memWrite, read_data);
  input clk, memWrite;
  input [31:0] write_data, mem_addr;
  output [31:0] read_data;
  
  reg [7:0] mem [63:0];
  integer k;
  
  initial
  begin
    for (k=0; k<64; k=k+1)
    mem[k] = k;
  end
  
  assign read_data = {mem[mem_addr+3],mem[mem_addr+2],mem[mem_addr+1],mem[mem_addr]};
  
  always @ (posedge clk)
  begin
    if (memWrite == 1'b1)
      {mem[mem_addr+3],mem[mem_addr+2],mem[mem_addr+1],mem[mem_addr]} = write_data;
    end
  endmodule
  
module tb_dm();
  reg clk = 0;
  reg memWrite;
  reg [31:0] write_data, mem_addr;
  wire [31:0] read_data;
  
  data_memory dm(clk, mem_addr, write_data, memWrite, read_data);
  
  always #5 clk = ~clk;
  initial begin
    memWrite = 1; //TEST CASE 1
    mem_addr = 32'h0; write_data = 32'hFFF; 
    #10
    memWrite = 0; // test  case 2
    mem_addr = 32'hA034; write_data= 32'h7654;
    #10 $finish;
  end
endmodule
    