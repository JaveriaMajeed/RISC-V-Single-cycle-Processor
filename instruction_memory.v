module instruction_memory (inst_addr, instruction);
  input [31:0] inst_addr;
  output [31:0] instruction;
  reg [7:0] mem [15:0];
  
  initial 
  begin
    mem[0]=8'h03;
    mem[1]=8'hA3;
    mem[2]=8'hC4;
    mem[3]=8'hFF;
    mem[4]=8'h23;
    mem[5]=8'hA4;
    mem[6]=8'h64;
    mem[7]=8'h00;
    mem[8]=8'h33;
    mem[9]=8'hE2;
    mem[10]=8'h62;
    mem[11]=8'h00;
    mem[12]=8'hE3;
    mem[13]=8'h0A;
    mem[14]=8'h42;
    mem[15]=8'hFE;
    
  end
  
  assign instruction = {mem[inst_addr+3],mem[inst_addr+2],mem[inst_addr+1],mem[inst_addr]};
endmodule
