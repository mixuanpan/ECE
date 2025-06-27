`default_nettype none
module fa (
  input logic A, B, Cin,
  output logic S, Cout
);
  assign S = A ^ B ^ Cin;
  assign Cout = (A & B) | (Cin & (A ^ B));
endmodule