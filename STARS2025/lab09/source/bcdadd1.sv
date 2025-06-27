`default_nettype none
module bcdadd1 (
  input logic [3:0] A, B,
  input logic Cin,
  output logic [3:0] S,
  output logic Cout
);
  logic [3:0] sum;
  logic Cout_;

  // Addition 
  assign {Cout_, sum} = A + B + {3'b0, Cin}; 

  // BCD 
  always_comb begin 
    if (sum > 4'd9 || Cout_) begin 
      S = sum + 4'd6; 
      Cout = 1; 
    end else begin 
      S = sum; 
      Cout = 0;
    end
  end
endmodule
