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
  // logic [7:0] item_price, balance; 

  // ssdec price (
  //   .in(pb[3:0]), 
  //   .enable(1'b1), 
  //   .out(item_price)
  // );
  logic [1:0] coin, item;
  
  // assign item = pb[17:16];
  // assign coin = pb[19:18]; 
  //ssdec coin_num (.in({2'b0, coin}), .enable(1'b1), .out(ss0)); 

  logic strobe; // strobe signal for synckey 
  logic [4:0] out; // output from synckey

  // synckey sk (
  //   .in(pb[19:0]),
  //   .clk(hz100),
  //   .rst(reset),
  //   .out(out), 
  //   .strobe(strobe)
  // );
  // ssdec sync (.in(out[3:0]), .enable(1'b1), .out(ss0)); 

  vm vm1 (
    .clk(pb[0]),
    .rst(reset),
    .coin(pb[19:18]), 
    .item(pb[17:16]), 
    //.item(item), 
    .state_out(right[7:0]), 
    // .blue(blue), 
    // .enable(1'b1), 
    .out({ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0}), 
    .balance(left[7:0]), 
    // .red(red), 
    .enable(pb[15])
  );

  // always_comb begin 
  //   green = 1'b0; red = 1'b0; blue = 1'b0;
  //   if(coin == 'd0) begin 
  //     green = 1'b1; 
  //   end else if (item == 'd0) begin 
  //     blue = 1'b1; 
  //   end else begin 
  //     red = 1'b1; 
  //   end
  // end 

endmodule
