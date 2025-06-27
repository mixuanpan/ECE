`default_nettype none
typedef enum logic [3:0]{
  LS0 = 0,
  LS1 = 1,
  LS2 = 2,
  LS3 = 3,
  LS4 = 4, 
  LS5 = 5, 
  LS6 = 6, 
  LS7 = 7,
  OPEN = 8,
  ALARM = 9,
  INIT = 10
} state_t;


module fsm (
  //put your ports here
  input logic clk, rst,
  input logic [4:0] keyout,
  input logic [31:0] seq,
  output state_t state
);

state_t c_state, n_state;

assign state = c_state;

always_ff @(posedge clk, posedge rst) begin
  if (rst) begin 
    c_state <= INIT;
  end else begin
    c_state <= n_state; 
  end
end

always_comb begin 
  case(c_state)
    INIT: 
      if(keyout == 5'h10) begin 
        n_state = LS0;
      end else begin 
        n_state = c_state; 
      end
    LS0: 
      if(keyout == {1'b0, seq[31:28]}) begin 
        n_state = LS1;
      end else begin 
        n_state = ALARM; 
      end
    LS1:
      if(keyout == {1'b0, seq[27:24]}) begin 
        n_state = LS2;
      end else begin 
        n_state = ALARM;
      end
    LS2:
      if(keyout == {1'b0, seq[23:20]}) begin 
        n_state = LS3;
      end else begin 
        n_state = ALARM;
      end
    LS3:
      if(keyout == {1'b0, seq[19:16]}) begin 
        n_state = LS4;
      end else begin 
        n_state = ALARM;
      end
    LS4:
      if(keyout == {1'b0, seq[15:12]}) begin 
        n_state = LS5;
      end else begin 
        n_state = ALARM;
      end
    LS5:  
      if(keyout == {1'b0, seq[11:8]}) begin
        n_state = LS6;
      end else begin 
        n_state = ALARM;
      end 
    LS6:
      if(keyout == {1'b0, seq[7:4]}) begin 
        n_state = LS7;
      end else begin
        n_state = ALARM;
      end
    LS7:
      if(keyout == {1'b0, seq[3:0]}) begin
        n_state = OPEN;
      end else begin 
        n_state = ALARM;
      end
    OPEN:
      if (keyout == 5'b00001) begin 
        n_state = LS0;
      end else begin 
        n_state = c_state;
      end
    default: 
      n_state = INIT;
  endcase
end
endmodule

