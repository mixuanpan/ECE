`default_nettype none
module synckey (
  input logic [19:0] in,
  input logic clk, rst,
  output logic [4:0] out, 
  output logic strobe
);


  always_comb begin
    out = 5'd0; // Default to avoid inferred latch 
    for (int i = 0; i < 20; i ++) begin
      if (in[i]) begin
        out = i[4:0]; 
      end
    end
  end
  
  logic [1:0] D; // input from the two d flip flops
  assign D[0] = | in;

  posedgedff dff1 (.clk(clk), .rst(rst), .D(D[0]), .Q(D[1]));
  posedgedff dff2 (.clk(clk), .rst(rst), .D(D[1]), .Q(strobe));

endmodule