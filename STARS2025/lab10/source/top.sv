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
  logic strobe; // strobe signal for synckey 
  logic [4:0] out; // output from synckey
  logic [7:0] Q; // output from register8
  synckey sk (
    .in(pb[19:0]),
    .clk(hz100),
    .rst(reset),
    .out(out), 
    .strobe(strobe)
  );
  
  logic [3:0] state;

  fsm fsm1 (
    .clk(strobe),
    .rst(reset),
    .keyout(out),
    .seq(seqsr_out),
    .state(state)
  );

  logic [31:0] seqsr_out;
  logic en; 
  
 
  assign en = (~pb[19] && ~pb[18] && ~pb[17] && ~pb[16]) && (state == 4'd10) ? 1'b1 : 1'b0; // INIT state 
  sequence_sr seqsr1 (
    .en(en), 
    .in(out), 
    .clk(strobe), 
    .rst(reset), 
    .out(seqsr_out)
  );

  display d1 (
    .ss({ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0}), 
    .state({1'b0, state}), 
    .seq(seqsr_out), 
    .red(red), 
    .green(green), 
    .blue(blue)
  );

  // ssdec ssdec1 (
  //   .in(seqsr_out[3:0]), 
  //   .enable(1'b1), 
  //   .out(ss0)
  // );

  // ssdec ssdec2 (
  //   .in(seqsr_out[7:4]), 
  //   .enable(1'b1), 
  //   .out(ss1)
  // );

  // ssdec ssdec3 (
  //   .in(seqsr_out[11:8]), 
  //   .enable(1'b1), 
  //   .out(ss2)
  // );

  // ssdec ssdec4 (
  //   .in(seqsr_out[15:12]), 
  //   .enable(1'b1), 
  //   .out(ss3)
  // );

  // ssdec ssdec5 (
  //   .in(seqsr_out[19:16]), 
  //   .enable(1'b1), 
  //   .out(ss4)
  // );

  // ssdec ssdec6 (
  //   .in(seqsr_out[23:20]), 
  //   .enable(1'b1), 
  //   .out(ss5)
  // );

  // ssdec ssdec7 (
  //   .in(seqsr_out[27:24]), 
  //   .enable(1'b1), 
  //   .out(ss6)
  // );

  // ssdec ssdec8 (
  //   .in(seqsr_out[31:28]), 
  //   .enable(1'b1), 
  //   .out(ss7)
  // );


  // // 8-bit register 
  // register8 reg8 (
  //   .clk(strobe),
  //   .rst(reset), 
  //   .D({3'b0, out}), 
  //   .Q(Q)
  // );

  // ssdec ssdec1 (
  //   .in(Q[3:0]),
  //   .enable(1'b1),
  //   .out(ss0)
  // );

  // ssdec ssdec2 (
  //   .in(Q[7:4]),
  //   .enable(1'b1),
  //   .out(ss1)
  // );

  // assign red = strobe;
endmodule

module register8 (
  input logic clk, rst,
  input logic [7:0] D,
  output logic [7:0] Q
);
  always_ff @(posedge clk, posedge rst) begin 
    if (rst) begin
      Q <= 8'b0;
    end else begin
      Q <= D;
    end 
  end
endmodule 
