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
  // clkdiv8k eightk (.clk(hz100), .rst(reset), .newclk(right[0])); 

  logic [7:0] dc1; 
  logic newclk;

  dc dutycycle (.clk(hz100), .rst(reset), .samples(pb[3:0]), .X(pb[19]), .pwm_out(), .wave(dc1)); 

  pwm drum (.clk(hz100), .rst(reset), .duty_cycle(dc1), .pwm_out(right[0])); 
endmodule
