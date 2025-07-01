module read_snare(
   input logic clk, rst, en, // 8k 
   output logic [7:0] idx
);

   logic [7:0] random [1:4096];
   initial begin
       $readmemh("clap.mem", random, 1, 981);
   end

   logic [7:0] current_count, next_count;

   always_ff @(posedge clk, posedge rst) begin
       if (rst) begin
           current_count <= 0;
       end else if(en) begin
           current_count <= next_count;
       end
   end

   assign idx = random[current_count] + 128;


   always_comb begin
       next_count = current_count + 1;
   end
endmodule
