`default_nettype none
module sequence_sr (
  //put your ports here
  input logic clk, rst, en,
  input logic [4:0] in,
  output logic [31:0] out
);
//your code starts here ...
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin 
      out <= 32'd0; 
    end else if (en) begin 
      out <= {out[27:0], in[3:0]};
    end 
  end

endmodule