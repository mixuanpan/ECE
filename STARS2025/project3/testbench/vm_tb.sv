`timescale 1ms/10ps
module vm_tb;
  logic [1:0] coin, item;  
  logic clk, rst, green, blue, red; 
  logic [7:0] dollars, cents, balance, price; 

  assign balance = cents + (dollars * 'd100);
  assign price = (item + 'd1) * 'd10; 

  vm vm1 (.coin(coin), .item(item), .clk(clk), .rst(rst), .dollars(dollars), .cents(cents));

  initial clk = 0; 
  always #1 ~clk; 

  task reset();
    begin 
      rst = 1; #10; 
      rst = 0; #10; 
    end
  endtask

  initial begin
    // make sure to dump the signals so we can see them in the waveform
    $dumpfile("waves/vm.vcd"); //change the vcd vile name to your source file name
    $dumpvars(0, vm_tb);
    // for loop to test all possible inputs
    for (integer i = 1; i <= 2; i++) begin
      for (integer j = 1; j <= 2; j++) begin
        //for (integer k = 0; k <= 1; k++) begin
        // set our input signals
        reset();
        item = i; coin = j; 
        // display inputs and outputs
        if (rst) begin 
          $display("A refund of \%b dollars \%b cents has been issued.\nCurrent Balance: 0$.\n", dollars, cents);
        end else if (balance >= price || balance >= 'd35) begin 
          $display("Dispensing \%b.", item);
          # 10; 
          $display("Current Balance: \%b dollars ")
        end else if ()
        $display("item=\%b, coin=\%b, dollars=\%b, cents=\%b", item, coin, dollars, cents, S);
        //end
      end
    end
  // finish the simulation
  #1 $finish;
  end
endmodule