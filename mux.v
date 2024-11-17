module mux (a,b,sel,c);
  input [31:0] a,b;
  input sel;
  output reg [31:0] c;
  
  always @(sel,a,b)
  begin
    if (sel)
      c = a;
    else 
      c = b;
    end
  endmodule
  
