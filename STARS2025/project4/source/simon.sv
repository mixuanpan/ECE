`default_nettype none

typedef enum logic [2:0]{
  RESET, 
  READY, 
  GAME,  
  EVAL, 
  FAIL, 
  RCOUNTER, 
  WIN
} state_t;

module simon (
  input logic clk, rst, start, 
  input logic en, // pb[19]
  input logic [15:0] in, // input combination 
  output logic [15:0] led_out, in_out, 
  output logic blue, green, red, 
  output logic [2:0] state, 
  output logic [63:0] ss // 7-seg display from the display function 
);

  // read random file 
  logic enable_file, en_blue; 
  logic [11:0] random_seq; // combanation to compare with 
  read f (.clk(clk), .rst(rst), .en(enable_file), .lsb(en_blue), .idx(random_seq)); 

  // read in each digit of the combination 
  logic [11:0] random_seq0, random_seq1, random_seq2, random_seq_n; 
  // logic [15:0] random_comb, random_comb0, random_comb1, random_comb2; 
  
  assign random_seq0 = {8'b0, random_seq [3:0]}; 
  assign random_seq1 = {8'b0, random_seq [7:4]}; 
  assign random_seq2 = {8'b0, random_seq [11:8]}; 
  assign state = c_state; 
  // ran_seq comb0 (.in(random_seq0), .enable(enable_file), .out(random_comb0)); 
  // ran_seq comb1 (.in(random_seq1), .enable(enable_file), .out(random_comb1)); 
  // ran_seq comb2 (.in(random_seq2), .enable(enable_file), .out(random_comb2)); 

  // timer
  logic [15:0] in_store; // store the final input as the timer runs out 
  logic newclk, enable_led, en_store; 
  // logic [15:0] ledshift_out; 
  ledclkdiv clkdiv (.clk(clk), .rst(rst), .newclk(newclk));
  ledshift timer (.clk(newclk), .rst(rst), .led(led_out), .en(enable_led), .readin_en(en_store)); 

  assign blue = en_blue && enable_led; 

  state_t c_state, n_state; // states; 
  logic [4:0] c_round, n_round; // counting the rounds 
  logic [39:0] seq; // seq to be passed to the display function 

  display d (.seq(seq), .ss(ss)); 

  logic pass; 
  input_check check (.in(in), .seq0(random_seq0 [3:0]), .seq1(random_seq1 [3:0]), .seq2(random_seq2 [3:0]), .pass(pass)); 

  always_ff @(posedge rst, posedge clk) begin 
    if (rst) begin 
      c_state <= RESET; 
      c_round <= 0;
    end else begin 
      c_state <= n_state; 
      c_round <= n_round; 
    end 
  end

  always_comb begin 
    enable_file = 1'b0; 
    // random_seq = 0; 
    enable_led = 0; 
    // in_store = 16'b1; 
    seq = 0; 
    n_state = c_state; 
    n_round = c_round; 
    green = 1'b0; 
    red = 1'b0; 
    // random_comb = 0;
    in_out = 0;  
    case (c_state) 
      RESET: begin 
        if (en) begin 
          n_state = READY; 
        end else begin 
          n_state = c_state; 
          n_round = c_round; 
        end
      end
//n_out = in;
      READY: begin 
        in_out = in; 
        seq = {25'b10100_01110_01010_01101_10110, 5'b10111, 5'b11001, c_round}; // READY? ROUND_NUM
        if (start) begin 
          enable_file = 1'b1; 
          n_state = GAME; 
        end else begin 
          n_state = c_state; 
        end
      end

      GAME: begin 
        seq = {20'b10001000001001101101, 5'b11001, random_seq2 [4:0], random_seq1 [4:0], random_seq0 [4:0]}; // HOLD SEQ_NUM 
        // random_seq = random_seq_n; 
        enable_led = 1'b1; 
        
        // random_comb = random_comb0 + random_comb1 + random_comb2; 
        if (~led_out[0]) begin
          // in_store = in; 
          n_state = EVAL;  
        end else begin 
          n_state = c_state; 
        end
      end

      EVAL: begin 
        
        if(en_blue) begin // Simon Says 
          if (pass) begin 
            n_round = c_round + 5'd1; 
            n_state = RCOUNTER; 
          end else begin 
            n_round = 0; 
            n_state = FAIL; 
          end
        end else begin // Simon didn't say shxt 
          if (in == 16'b0) begin 
            red = 1'b1;
            n_round = c_round + 'd1; 
            n_state = RCOUNTER; 
        end else begin 
            n_round = 0; 
            n_state = FAIL; 
        end
        end
      end

      FAIL: begin 
        seq = {40'b10101_10100_10110_01010_10000_01010_00001_11000}; // TRY AGAIN 
        if (en) begin 
          n_state = RCOUNTER; 
        end else begin 
          n_state = c_state; 
          n_round = c_round; 
        end
      end

      RCOUNTER: begin 
        if (c_round > 'd9) begin 
          n_state = WIN; 
        end else begin 
          n_state = READY; 
          // n_round = c_round; 
        end 
      end

      WIN: begin 
        seq = {20'b10000_00000_00000_01101, 5'b11001, 15'b10010_00000_01011}; // GOOD JOB 
        if (en) begin 
          n_state = RESET; 
        end else begin 
          n_state = c_state; 
          n_round = c_round; 
        end 
      end

      default: begin 
        seq = 0; 
      end
    endcase
  end
endmodule
