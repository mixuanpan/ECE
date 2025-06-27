`timescale 1ms/10ps
module fa4_tb;
  logic [3:0] A, B, S;
  logic Cin, Cout;
  fa4 fulladder (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
  initial begin
    // make sure to dump the signals so we can see them in the waveform
    $dumpfile("waves/fa4.vcd"); // change the vcd file name to your source file name
    $dumpvars(0, fa4_tb);
    // for loop to test all possible inputs
    for (integer i = 0; i < 16; i++) begin
      for (integer j = 0; j < 16; j++) begin
        for (integer k = 0; k <= 1; k++) begin
          // set our input signals
          A = i; B = j; Cin = k;
          #1;
          // display inputs and outputs
          $display("A=\%b, B=\%b, Cin=\%b, Cout=\%b, S=\%b", A, B, Cin, Cout, S);
        end
      end
    end
    // finish the simulation
    #1 $finish;
  end
endmodule