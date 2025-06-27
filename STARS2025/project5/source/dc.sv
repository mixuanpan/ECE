`default_nettype none
module dc (
  //put your ports here
  input clk, rst, // 2M clk 
  input logic [3:0] samples, // pb[3:0]
  input logic X,  // pb[17] -> active high reset button 
  output logic pwm_out, // pwn output to play the samples through  /home/shay/a/pan453/STARS 2025/lab09/source/enc20to5.sv
  output logic [7:0] wave
);
//your code starts here ...
  logic [7:0] c_out, n_out, out_cl, out_hi, out_ki, out_sn;  
  logic c_pwm, n_pwm; 
  logic [2:0] count, n_count; 
  assign wave = c_out; 
  assign c_pwm = pwm_out; 

  logic read_clk; 

  clkdiv8k eightk (.clk(clk), .rst(rst), .newclk(read_clk)); 


  // read through the files at 8k 
  logic [7:0] clap, hihat, kick, snare; 
  read_clap hitClap (.clk(clk), .rst(rst), .en(read_clk), .idx(clap)); 
  read_hihat hitHihat (.clk(clk), .rst(rst), .en(read_clk), .idx(hihat)); 
  read_kick hitKick (.clk(clk), .rst(rst), .en(read_clk), .idx(kick)); 
  read_snare hitSnare (.clk(clk), .rst(rst), .en(read_clk), .idx(snare)); 

  logic pwm_clk; 
  clkdiv2M twom (.clk(clk), .rst(rst), .newclk(pwm_clk)); 

  always_ff @(posedge clk, posedge rst) begin 
    if (rst) begin 
      c_out <= 0; 
      c_pwm <= 0; 
      count <= 0; 
    end else begin 
      c_out <= n_out; 
      c_pwm <= n_pwm; 
      count <= n_count; 
    end
  end 

  always_comb begin 
    out_cl = 0; 
    out_hi = 0; 
    out_ki = 0; 
    out_sn = 0; 
    if (samples[0]) begin // clap 
      out_cl = c_out + clap;   
    end
    
    if (samples[1]) begin // hihat 
      out_hi = c_out + hihat; 
    end
    
    if (samples[2]) begin // kick 
      out_ki = c_out + kick; 
    end 
    
    if (samples[3]) begin // snare
      out_sn = c_out + snare; 
    end

    n_out = out_cl + out_hi + out_ki + out_sn; 

    end

endmodule