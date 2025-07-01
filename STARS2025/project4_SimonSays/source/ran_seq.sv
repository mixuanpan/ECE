`default_nettype none
module ran_seq (
  //put your ports here
  input logic [11:0] in, 
  input logic enable, 
  output logic [15:0] out
);
//your code starts here ...
  always_comb begin 
    if(enable) begin
      case(in) 
        12'b00000: begin out = 16'b1; end// 0
        12'b00001: begin out = 16'b10; end// 1
        12'b00010: begin out = 16'b100; end //2 
        12'b00011: begin out = 16'b1000; end //3
        12'b00100: begin out = 16'b10000; end //4
        12'b00101: begin out = 16'b100000; end //5
        12'b00110: begin out = 16'b1000000; end //6
        12'b00111: begin out = 16'b10000000; end //7
        12'b01000: begin out = 16'b100000000; end //8
        12'b01001: begin out = 16'b1000000000; end //9
        12'b01010: begin out = 16'b10000000000; end //A
        12'b01011: begin out = 16'b100000000000; end // b
        12'b01100: begin out = 16'b1000000000000; end // C
        12'b01101: begin out = 16'b10000000000000; end // d
        12'b01110: begin out = 16'b100000000000000; end // E
        12'b01111: begin out = 16'b1000000000000000; end // F
        default: begin out = 16'b00000000; end // Default case
      endcase
    end
    else begin 
      out = 16'b00000000;
    end
  end

endmodule