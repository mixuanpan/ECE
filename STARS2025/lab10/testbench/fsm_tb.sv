`timescale 1ms/10ps

// typedef enum logic [3:0]{
//   LS0 = 0,
//   LS1 = 1,
//   LS2 = 2,
//   LS3 = 3,
//   LS4 = 4, 
//   LS5 = 5, 
//   LS6 = 6, 
//   LS7 = 7,
//   OPEN = 8,
//   ALARM = 9,
//   INIT = 10
// } state_t;


module fsm_tb;
  logic strobe, rst;
  logic [4:0] keyout;
  logic [31:0] seq;
  logic [3:0] state; 
  

  fsm fsm1 (.clk(strobe), .rst(rst), .keyout(keyout), .seq(seq), .state(state));
  
  task toggle_rst;
    rst = 1; #10; 
    rst = 0; #10; 
  endtask

  initial strobe = 0;
  always strobe = #10 ~strobe; 

  assign seq = 32'h12345678;
  
  initial begin
    // make sure to dump the signals so we can see them in the waveform
    $dumpfile("waves/fsm.vcd"); //change the vcd vile name to your source file name
    $dumpvars(0, fsm_tb);
    // for loop to test all possible inputs
    // seq = 32'd45678901;
    rst = 1; #10;
    rst = 0;
    keyout = 5'd0; # 15;
    keyout = 5'd1; # 15;
    keyout = 5'd1; # 15;
    keyout = 5'h2; #20;
    keyout = 5'd3; # 20;
    keyout = 5'd4; #20;
    keyout = 5'd5; # 20;
    keyout = 5'd6; #20;
    keyout = 5'd7; #20;
    keyout = 5'd8; #20;
    rst = 1; #20;
    
    $display("clk=\%b, rst=\%b, keyout=\%b, seq=\%b, state=\%b", strobe, rst, keyout, seq, state);
    // end
  // finish the simulation
  #1 $finish;
  end
endmodule
