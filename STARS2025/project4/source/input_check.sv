`default_nettype none
module input_check (
  //put your ports here
  input logic [15:0] in, 
  input logic [3:0] seq0, seq1, seq2, 
  output logic pass
);
//your code starts here ...
  logic [1:0] count; 
  logic t1, t2; 
  always_comb begin 

    count = 0; 
    pass = 0; 
    t1 = 0; 
    t2 = 0; 
    // pressed buttons count 
    for (int i = 0; i < 16; i++) begin 
      if (in[i] == 1'b1) begin 
        count ++; 
      end 
    end 

    if (in[seq0] && in[seq1] && in[seq2]) begin 
      t1 = 1'b1; 
    end 

    if (seq0 == seq1 || seq0 == seq2 || seq1 == seq2) begin 
      if (count == 'd2) begin 
        t2 = 1'b1; 
      end else begin 
        t2 = 1'b0; 
      end 
    end else begin // distinct seq
      if (count == 3) begin 
        t2 = 1'b1;
      end else begin 
        t2 = 1'b0; 
      end 
    end 
    pass = t1 && t2; 
  end

endmodule