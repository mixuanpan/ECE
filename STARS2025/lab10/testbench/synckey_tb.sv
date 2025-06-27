`timescale 1ms/10ps
module synckey_tb;
  logic [19:0] in;
  logic [4:0] out;
  logic strobe, clk, reset;
  logic [4:0] exp_q; // expected output
  logic total_tests, passed_tests;
  synckey key (.in(in), .clk(clk), .rst(reset), .out(out), .strobe(strobe));
  
  task check_output;
    total_tests++;
    if (exp_q != out) 
      $display("Error: q = $1d, expected %1d", out, exp_q);
    else
      passed_tests++;
  endtask

  task toggle_reset;
    reset = 1; #10;
    reset = 0; #10;
  endtask

  // task toggle_clk;
  //   clk = 1; #10;
  //   clk = 0; #10;
  // endtask
  initial clk = 0; // Initialize clock to 0
  always clk = #10 ~clk;
  initial begin
    // make sure to dump the signals so we can see them in the waveform
    $dumpfile("waves/synckey.vcd"); //change the vcd vile name to your source file name
    $dumpvars(0, synckey_tb);
    // for loop to test all possible inputs
    in = 20'b0; // Initialize input to zero
    reset = 0; clk = 0; 
    // strobe = 0;
    total_tests = 0; passed_tests = 0;
    #10;
    reset = 0; 
    exp_q = 0;
    #10;
    check_output;
    toggle_reset;
    for (integer i = 0; i <= 20; i++) begin
      // set our input signals
      in[i] = 1'b1;
      #20;
      in[i] = 1'b0;
      #30;
      // display inputs and outputs
      $display("clk=\%b, rst=\%b, in=\%b, out=\%b, strobe=\%b", clk, reset, in, out, strobe);
      //toggle_clk;
    end
  // finish the simulation
  #1 $finish;
  end
endmodule