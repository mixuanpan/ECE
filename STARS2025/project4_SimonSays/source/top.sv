`default_nettype none
// Empty top module

module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);
  // Your code goes here...
  logic [15:0] in_out, x; 
  simon simonSays (
    .clk(hz100), 
    .rst(reset), 
    .en(pb[19]), 
    .start(pb[18]), 
    .in(pb[15:0]), 
    .led_out({left, right}), 
    .state(), 
    .blue(blue), 
    .ss({ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0}), 
    .green(green), 
    .red(red), 
    .in_out()
  ); 
  
  
  // testing t1 (
  //   .in(pb[15:0]), 
  //   .out({left, right}), 
  //   .blue(blue)
  // );

  // testing2 t2 (
  //   .in(pb[15:0]), 
  //   .out({left, right}), 
  //   .blue(blue)
  // );

  // input_check t3 (
  //   .in(pb[15:0]), 
  //   .seq0(4'b0),
  //   .seq1(4'd4), 
  //   .seq2(4'd5), 
  //   .pass(blue) 
  // );
  
endmodule

