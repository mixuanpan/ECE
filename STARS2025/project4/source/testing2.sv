`default_nettype none
// Empty top module
module testing2 (
  input logic [15:0] in, 
  output logic [15:0] out, 
  output blue
);
  logic enable_file; 
  logic [11:0] random_seq; 

  assign enable_file = 1'b1; 

  assign random_seq = 12'ha15; 

  // read in each digit of the combination 
  logic [11:0] random_seq0, random_seq1, random_seq2, random_seq_n; 
  logic [15:0] random_comb, random_comb0, random_comb1, random_comb2; 
  
  assign random_seq0 = {8'b0, random_seq [3:0]}; 
  assign random_seq1 = {8'b0, random_seq [7:4]}; 
  assign random_seq2 = {8'b0, random_seq [11:8]}; 

  ran_seq comb0 (.in(random_seq0), .enable(enable_file), .out(random_comb0)); 
  ran_seq comb1 (.in(random_seq1), .enable(enable_file), .out(random_comb1)); 
  ran_seq comb2 (.in(random_seq2), .enable(enable_file), .out(random_comb2)); 

  assign random_comb = random_comb0 + random_comb1 + random_comb2; 
  assign out = random_comb; 
  assign blue = (in == random_comb)? 1'b1: 1'b0; 
endmodule
