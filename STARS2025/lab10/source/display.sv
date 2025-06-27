`default_nettype none
module display (
  //put your ports here
  input logic [4:0] state,
  input logic [31:0] seq,
  output logic [63:0] ss, // 7-segment display
  output logic red, green, blue
);
//your code starts here ...
  logic [7:0] ss0, ss1, ss2, ss3, ss4, ss5, ss6, ss7;
  ssdec ssdec1 (
    .in(seq[3:0]), 
    .enable(1'b1), 
    .out(ss0)
  );

  ssdec ssdec2 (
    .in(seq[7:4]), 
    .enable(1'b1), 
    .out(ss1)
  );

  ssdec ssdec3 (
    .in(seq[11:8]), 
    .enable(1'b1), 
    .out(ss2)
  );

  ssdec ssdec4 (
    .in(seq[15:12]), 
    .enable(1'b1), 
    .out(ss3)
  );

  ssdec ssdec5 (
    .in(seq[19:16]), 
    .enable(1'b1), 
    .out(ss4)
  );

  ssdec ssdec6 (
    .in(seq[23:20]), 
    .enable(1'b1), 
    .out(ss5)
  );

  ssdec ssdec7 (
    .in(seq[27:24]), 
    .enable(1'b1), 
    .out(ss6)
  );

  ssdec ssdec8 (
    .in(seq[31:28]), 
    .enable(1'b1), 
    .out(ss7)
  );

  always_comb begin 
    green = 0;
    blue = 0;
    red = 0;
    if (state == 5'd10) begin // init 
      // see the output of the sequence_sr register (seq) on the 8 7-segent display
      ss = {ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0};
    end else if (state == 5'd8) begin // open 
      ss = {32'b0, 32'b00111111011100110111100101010100};
      green = 1'b1;
    end else if (state == 5'd9) begin 
      ss = 64'b0011100101110111001110000011100000000000011001110000011000000110;
      red = 1'b1; 
    end else begin 
      ss = 64'b0; 
      blue = 1'b1;
      if (state == 5'd0) begin 
        ss = {1'b1, 63'b0};
      end else if (state == 5'd1) begin 
        ss = {8'b0, 1'b1, 55'b0};
      end else if (state == 5'd2) begin 
        ss = {16'b0, 1'b1, 47'b0};
      end else if (state == 5'd3) begin 
        ss = {24'b0, 1'b1, 39'b0};
      end else if (state == 5'd4) begin 
        ss = {32'b0, 1'b1, 31'b0};
      end else if (state == 5'd5) begin 
        ss = {40'b0, 1'b1, 23'b0};
      end else if (state == 5'd6) begin 
        ss = {48'b0, 1'b1, 15'b0};
      end else if (state == 5'd7) begin 
        ss = {56'b0, 1'b1, 7'b0}; 
      end else begin 
        ss = {32'b0, 32'b1111111111111111111111111111111};
    end
  end 
  end 
endmodule