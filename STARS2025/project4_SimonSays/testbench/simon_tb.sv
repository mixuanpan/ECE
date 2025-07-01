`timescale 1ms/10ps
typedef enum logic [2:0]{
  RESET, 
  READY, 
  GAME,  
  EVAL, 
  FAIL, 
  RCOUNTER, 
  WIN
} state_t;


module simon_tb;
  logic clk, rst, start, en, blue, green; 
  logic [15:0] in, led_out, in_out;
  logic [63:0] ss;
  logic [3:0] seq0, seq1, seq2; 
  simon simon1 (.clk(clk), .rst(rst), .in_out(in_out), .start(start), .en(en), .in(in), .led_out(led_out), .blue(blue), .green(green), .ss(ss));
  
  initial clk = 0;
  always clk = #1 ~clk; 

  task reset();
  begin 
    rst = 1; #4; 
    rst = 0; ; 
  end 
  endtask 

  initial begin
    
    // make sure to dump the signals so we can see them in the waveform
    rst = 0;
    $dumpfile("waves/simon.vcd"); //change the vcd vile name to your source file name
    $dumpvars(0, simon_tb);
        reset(); 
    // for loop to test all possible inputs
    for (integer i = 0; i <= 1; i++) begin
      for (integer j = 0; j <= 1; j++) begin
        // for (integer k = 0; k <= 1; k++) begin
        // set our input signals
        
        start = i[0]; en = j[0]; 
        in = 16'b0000_01001_000001; 
        seq0 = in_out[3:0]; seq1 = in_out[7:4]; seq2 = in_out[11:8]; 
        #2;
        // display inputs and outputs
        $display("start=\%b, en=\%b, in=\%b, led_out=\%b, ss=\%b, in_out", start, en, in, led_out, ss, in_out);
        // end
      end
    end
  // finish the simulation
  #1 $finish;
  end
endmodule