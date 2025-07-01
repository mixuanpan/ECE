module clkdiv8k (
   input logic clk, rst,
   output logic newclk
);


//reduce reuse recycle


   logic [10:0] count, count_n;
   logic newclk_n;

   always_ff @(posedge clk, posedge rst) begin
      if (rst) begin
           count <= '0;
        //    newclk <= '0;
      end else begin
           count <= count_n;
        //    newclk <= newclk_n;
      end
   end


   always_comb begin
       count_n = count;
       if (count == 11'd1499) begin
           count_n = 0;
           newclk = 1; 
       end else begin
            newclk = 0; 
            count_n = count + 1; 
        //    if (count > 255) begin 
        //     count_n = 'd1; 
        //    end else begin 
        //          count_n = '0;
        //    end 
       end
      
   end


endmodule
