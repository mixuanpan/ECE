`default_nettype none
module ssdec (
  //put your ports here
  input logic [4:0] in, 
  input logic enable, 
  output logic [7:0] out
);
//your code starts here ...
  always_comb begin 
    if(enable) begin
      case(in) 
        5'b00000: begin out = 8'b00111111; end// 0
        5'b00001: begin out = 8'b00000110; end// 1
        5'b00010: begin out = 8'b01011011; end //2 
        5'b00011: begin out = 8'b01001111; end //3
        5'b00100: begin out = 8'b01100110; end //4
        5'b00101: begin out = 8'b01101101; end //5
        5'b00110: begin out = 8'b01111101; end //6
        5'b00111: begin out = 8'b00000111; end //7
        5'b01000: begin out = 8'b01111111; end //8
        5'b01001: begin out = 8'b01100111; end //9
        5'b01010: begin out = 8'b01110111; end //A
        5'b01011: begin out = 8'b01111100; end // b
        5'b01100: begin out = 8'b00111001; end // C
        5'b01101: begin out = 8'b01011110; end // d
        5'b01110: begin out = 8'b01111001; end // E
        5'b01111: begin out = 8'b01110001; end // F
        5'b10000: begin out = 8'b1101111; end //g
        5'b10001: begin out = 8'b1110110; end //H
        5'b10010: begin out = 8'b0011110; end //j
        5'b10011: begin out = 8'b0111000; end // L
        5'b10100: begin out = 8'b1010000; end //r
        5'b10101: begin out = 8'b1111000; end //t
        5'b10110: begin out = 8'b1101110; end //y
        5'b10111: begin out = 8'b1010011; end //?
        5'b11000: begin out = 8'b01010100; end // n
        5'b11001: begin out = 8'b00000000; end // space 
        default: begin out = 8'b00000000; end // Default case
      endcase
    end
    else begin 
      out = 8'b00000000;
    end
  end

endmodule