`default_nettype none
module fa4 (
  input logic [3:0] A, B,
  input logic Cin,
  output logic [3:0] S,
  output logic Cout
);
  logic [2:0] C;
  fa adder1 (
    .A(A[0]), .B(B[0]), .Cin(Cin),
    .S(S[0]), .Cout(C[0])
  );
  fa adder2 (
    .A(A[1]), .B(B[1]), .Cin(C[0]),
    .S(S[1]), .Cout(C[1])
  );
  fa adder3 (
    .A(A[2]), .B(B[2]), .Cin(C[1]),   
    .S(S[2]), .Cout(C[2])
  );
  fa adder4 (
    .A(A[3]), .B(B[3]), .Cin(C[2]),
    .S(S[3]), .Cout(Cout)
  );
endmodule
