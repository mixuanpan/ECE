`default_nettype none
module display (
  input logic [39:0] seq,
  output logic [63:0] ss // 7-segment display
);
//your code starts here ...
  logic [7:0] ss0, ss1, ss2, ss3, ss4, ss5, ss6, ss7;
  
  ssdec ssdec1 (
    .in(seq[4:0]), 
    .enable(1'b1), 
    .out(ss0)
  );

  ssdec ssdec2 (
    .in(seq[9:5]), 
    .enable(1'b1), 
    .out(ss1)
  );

  ssdec ssdec3 (
    .in(seq[14:10]), 
    .enable(1'b1), 
    .out(ss2)
  );

  ssdec ssdec4 (
    .in(seq[19:15]), 
    .enable(1'b1), 
    .out(ss3)
  );

  ssdec ssdec5 (
    .in(seq[24:20]), 
    .enable(1'b1), 
    .out(ss4)
  );

  ssdec ssdec6 (
    .in(seq[29:25]), 
    .enable(1'b1), 
    .out(ss5)
  );

  ssdec ssdec7 (
    .in(seq[34:30]), 
    .enable(1'b1), 
    .out(ss6)
  );

  ssdec ssdec8 (
    .in(seq[39:35]), 
    .enable(1'b1), 
    .out(ss7)
  );

  always_comb begin 
    ss = {ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0}; 
  end 
  
endmodule