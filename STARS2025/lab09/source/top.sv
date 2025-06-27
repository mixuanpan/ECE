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
  // ssdec inst1 (.in(pb[3:0]

/*   ssdec A (.in(pb[3:0]), .enable(1'b1), .out(ss7));
  ssdec B (.in(pb[7:4]), .enable(1'b1), .out(ss5));
  bcdadd1 bcd (.A(pb[3:0]), .B(pb[7:4]), .Cin(1'b0),
           .S(tempa), .Cout(tempb));

  logic [3:0] tempa;
  logic tempb;

  ssdec C (.in(tempa), .enable(1'b1), .out(ss0));
  ssdec D (.in({3'b0, tempb}), .enable(1'b1), .out(ss1));    */     
  
  enc20to5 enc1 (.in(pb[19:0]), .out(right[4:0]), .strobe(red));

endmodule
