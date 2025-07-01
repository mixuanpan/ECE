module clkdiv2M (
   input logic clk, rst,
   output logic newclk
);


//reduce reuse recycle


   logic [2:0] count, count_n;
   logic newclk_n;


   always_ff @(posedge clk, posedge rst) begin
      if (rst) begin
           count <= '0;
           newclk <= '0;
      end else begin
           count <= count_n;
           newclk <= newclk_n;
      end
   end


   always_comb begin
       count_n = count;
       newclk_n = newclk;
       if (count < 3'd2) begin
           count_n = count + 1;
       end else begin
           count_n = '0;
           newclk_n = !newclk;
       end
   end


endmodule
