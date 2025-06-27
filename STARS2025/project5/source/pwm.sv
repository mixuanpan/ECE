`default_nettype none

module pwm (
   input clk,
   input rst,
   input [7:0] duty_cycle,
   output logic pwm_out
);
   logic [7:0] counter;

//    logic pwm_clk; 
//    clkdiv2M twom (.clk(clk), .rst(rst), .newclk(pwm_clk));

   // Counter logic
   always_ff @(posedge clk) begin
       if (rst) begin
           counter <= 0;
       end else begin
           counter <= counter + 1;
       end
   end

   // Comparator logic
   always_comb begin
       if (counter < duty_cycle) begin
           pwm_out = 1;
       end else begin
           pwm_out = 0;
       end
   end

endmodule

