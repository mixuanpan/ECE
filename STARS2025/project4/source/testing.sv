`default_nettype none
// Empty top module
module testing (
  input logic [15:0] in, 
  output logic [15:0] out, 
  output logic blue
);
  assign out = in; 
  
  always_comb begin 
    if (~out[0]) begin 
      blue = 1'b1; 
    end else begin 
      blue = 1'b0; 
    end
  end

endmodule
