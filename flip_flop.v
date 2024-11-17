module flip_flop(a,v,y);
  input [3:0] a;
  input v;
  output reg [1:0] y;
  
  always @ (*)
    if (v==1)
      casex (a)
        4'b1xxx: y= 2'b11;
        4'b01xx: y = 2'b01;
        4'b001x: y = 2'b10;
        4'b0001: y = 2'b00;
      endcase
    else y = 2'b00;
  
  endmodule
  
  module tb_flip();
    reg [3:0] a;
    reg v;
    wire [1:0] y;
    flip_flop f1(a,v,y);
    
    initial 
    begin 
      v = 1;
      #10 a = 4'b1000;
      #10 a = 4'b0111;
      #10 a = 4'b0011;
      #10 a = 4'b0001;
      #10 v = 0;
      $finish;
    end
  endmodule