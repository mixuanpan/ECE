module read(
   input logic clk, rst,
   input logic en,
   output logic lsb,
   output logic [11:0] idx
);

   logic [11:0] random [1:4096];
   initial begin
       $readmemh("press.mem", random, 1, 256);
   end


   logic [7:0] current_count, next_count;


   always_ff @(posedge clk, posedge rst) begin
       if (rst) begin
           current_count <= 0;
       end else if(en) begin
           current_count <= next_count;
       end
   end


   assign lsb = idx[0];
   assign idx = random[current_count];


   always_comb begin
       next_count = current_count + 1;
   end
endmodule
