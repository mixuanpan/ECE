`default_nettype none
module posedgedff (
  //put your ports here
  input logic clk, rst, D,
  output logic Q
);
//your code starts here ...
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin 
      Q <= 1'd0; 
    end else if (clk) begin 
      Q <= D;
    end
  end

endmodule