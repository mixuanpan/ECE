`default_nettype none 

typedef enum logic [1:0] {
  INIT,
  INSERT, 
  DISPENSING, 
  REFUND
} state_t;

typedef enum logic [1:0] {
  NICKEL = 2'b01, 
  DIME = 2'b10, 
  QUARTER = 2'b11 
} coin_t; 

typedef enum logic [1:0] {
  // NONE = 2'b00, 
  SOJU = 2'b01, // 20 cents 
  CHOYA = 2'b10 // 30 cents 
} item_t;

module vm (
  input logic clk, rst, enable,
  input coin_t coin, 
  input item_t item, 
  // output logic [7:0] balance, 
  output logic [63:0] out, // ssdec output display 
  // output logic blue,  // on when displaying balance 
  output logic [7:0] state_out, balance // state on right led's, binary representation on left led's
);

  state_t c_state, n_state; 
  logic [7:0] c_balance, n_balance, n_balance_out0, n_balance_out1, COIN_VAL;
  logic [7:0] E, F, d, ONE, S, P, n; 

  logic [7:0] price, n_price; 
  logic [7:0] balance_out_1, balance_out_0; 
  logic strobe; 

  assign balance_out_1 = balance / 'd10; 
  assign balance_out_0 = balance % 'd10; 

  ssdec sk0 (.in(balance_out_0 [3:0]), .enable(1'b1), .out(n_balance_out0));
  ssdec sk1 (.in(balance_out_1 [3:0]), .enable(1'b1), .out(n_balance_out1));

  ssdec E1 (.in(4'b1110), .enable(1'b1), .out(E));
  ssdec F1 (.in(4'b1111), .enable(1'b1), .out(F)); 
  ssdec d1 (.in(4'b1101), .enable(1'b1), .out(d)); 
  ssdec ONE1 (.in(4'b0001), .enable(1'b1), .out(ONE));
  ssdec COIN (.in({2'b0, coin}), .enable(1'b1), .out(COIN_VAL));

  assign S = 8'b01101101;
  assign P = 8'b01110011; 
  assign n = 8'b01010100; 
  assign balance = c_balance; 

  always_ff @(posedge clk, posedge rst) begin 
    if(rst) begin 
      c_state <= REFUND; 
      c_balance <= 'd0;
      price <= '0; 
    end else begin 
      c_state <= n_state; 
      c_balance <= n_balance; 
      price <= n_price; 
    end
  end

  always_comb begin
    n_balance = 0; 
    n_price = price;
    // blue = 1'b0; 
    state_out = 8'b0;
    out = {48'b0, n_balance_out1, n_balance_out0}; 
    // red = 0; 
    n_state = c_state; 

    case(c_state) 
      INIT: begin 
        state_out = 8'b00000001;
        // red = 1'b1; 
        if (c_balance > 0) begin 
          out = {48'b0, n_balance_out1, n_balance_out0}; 
        end else begin 
          out = {S, E, 8'b00111000, E, 8'b00111001, 8'b01111000, 16'b0}; // select 
        end

        case(item) 
          SOJU: begin 
            n_price = 'd20; 
            out = {32'b0, S, 8'b00111111, 8'b00000111, 8'b00111110};  
            n_state = INSERT;
          end
          CHOYA: begin 
            n_price = 'd30; 
            out = {24'b0, 24'b001110010111011000111111, 8'b01101110, 8'b01110111};
            n_state = INSERT; 
          end 
          default: begin 
            n_price = 0; 
            n_state = c_state;  
            n_balance = 0; 
          end
        endcase
      end

      INSERT: begin 
        state_out = 8'b00000010;
        // if (price == 'd20) begin 
        //     out = {32'b0, S, 8'b00111111, 8'b00001110, 8'b00111110};  
        // end else begin 
        //   out = {24'b0, 24'b001110010111011000111111, 8'b01101110, 8'b01110111}; 
        // end 
    
        if (c_balance >= price || c_balance >= 'd35) begin 
          // out = {d, ONE, S, P, E, n, S, E};
          // n_balance = c_balance - price; 
          n_state = DISPENSING; 
        end else begin
          n_state = c_state; 
        end 
          out = {48'b0, n_balance_out1, n_balance_out0}; 
          case (coin)  
            NICKEL: begin 
              n_balance = c_balance + 'd5; 
              out = {48'b0, n_balance_out1, n_balance_out0}; 
            end 

            DIME: begin 
              n_balance = c_balance + 'd10;
              out = {48'b0, n_balance_out1, n_balance_out0}; 
            end

            QUARTER: begin 
              n_balance = c_balance + 'd25; 
              out = {48'b0, n_balance_out1, n_balance_out0}; 
            end 
            default: begin 
              n_balance = c_balance; 
              out = {48'b0, n_balance_out1, n_balance_out0}; 
            end 
          endcase 
        end
        

      DISPENSING: begin 
        state_out = 8'b00000100;
        out = {d, ONE, S, P, E, n, S, E};
        n_balance = c_balance - price; 

        if (enable) begin 
          n_state = INIT; 
        end else begin 
          n_state = c_state; 
        end
      end

      REFUND: begin 
        state_out = 8'b00001000; 
        if (enable) begin 
          n_balance = c_balance;  
          n_state = INIT;
        end else begin 
          out = {16'b0, 8'b01010000, E, F, 8'b00111110, n, d}; 
          n_balance = 0; 
        end
      end 

      default: begin 
        n_balance = 0; 
        n_state = INIT; 
        out = 64'b1111111111111111111111111111111111111111111111111111111; 
        state_out = 8'b11111111;
        n_price = price; 
      end
    endcase
  end
endmodule

