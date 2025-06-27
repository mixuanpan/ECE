`timescale 1ms/10ps
module ssdec_tb;
  logic [3:0] in;
  logic enable;
  logic [6:0] ssX;
  ssdec s0 (.in(in), .enable(enable), .out(ssX)); 

  function integer ss_to_int(logic [6:0] ss);
    case(ss)
      7'b0111111: return 0; // 0
      7'b0000110: return 1; // 1
      7'b1011011: return 2; // 2
      7'b1001111: return 3; // 3
      7'b1100110: return 4; // 4
      7'b1101101: return 5; // 5
      7'b1111101: return 6; // 6
      7'b0000111: return 7; // 7
      7'b1111111: return 8; // 8
      7'b1100111: return 9; // 9
      7'b1110111: return 10; // A
      7'b1111100: return 11; // b
      7'b0111001: return 12; // C
      7'b1011110: return 13; // d
      7'b1111001: return 14; // E
      7'b1110001: return 15; // F
      default:    return -1; // Invalid input
    endcase
  endfunction

  initial begin
    // make sure to dump the signals so we can see them in the waveform
    $dumpfile("waves/ssdec.vcd"); //change the vcd vile name to your source file name
    $dumpvars(0, ssdec_tb);
    enable = 1; // enable the decoder
    #10;
    // for loop to test all possible inputs
    for (integer i = 0; i <= 15; i++) begin
      in = i; // set the input
      #10; // wait for the output to settle
      if (ss_to_int(ssX) != i) begin 
        $display("Erro: %d != %d", ss_to_int(ssX), i);
      end 
      else begin
        $display("Success.");
      end
    end
  // finish the simulation
  #1 $finish;
  end
endmodule