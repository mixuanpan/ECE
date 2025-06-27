`default_nettype none
module enc20to5 (
  input logic [19:0] in,
  output logic [4:0] out, 
  output logic strobe
);

  assign strobe = |in; // Strobe is high if any input bit is high

  always_comb begin
    out = 5'd0; // Default to avoid inferred latch 
    for (int i = 0; i < 20; i ++) begin
      if (in[i]) begin
        out = i[4:0]; 
      end
    end
  end
endmodule