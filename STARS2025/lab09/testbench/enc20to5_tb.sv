`timescale 1ms/10ps
module enc20to5_tb;
  logic [19:0] in;
  logic [4:0] out;
  logic strobe;
  enc20to5 encoder (.in(in), .out(out), .strobe(strobe));
  initial begin
    // make sure to dump the signals so we can see them in the waveform
    $dumpfile("waves/enc20to5.vcd"); //change the vcd vile name to your source file name
    $dumpvars(0, enc20to5_tb);
    // for loop to test all possible inputs
    in = 20'b0; // Initialize input to zero
    for (integer i = 0; i <= 20; i++) begin
        // set our input signals
        in[i] = 1'b1;
        #1;
        // display inputs and outputs
        $display("in=\%b, out=\%b, strobe=\%b", in, out, strobe);
    
    end
  // finish the simulation
  #1 $finish;
  end
endmodule