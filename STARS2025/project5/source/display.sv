// `default_nettype none
// module display (
//     input clk, rst, // 2M clk 
//     input [7:0] seq, 
//     output led
// ); 
//     logic c_led, n_led; 
//     logic [2:0] i; 
//     assign led = c_led; 

//     always_ff @(posedge clk, posedge rst) begin 
//         if (rst) begin 
//             i <= 0; 
//             c_led <= seq[i]; 
//         end else begin 
            
//             c_led <= n_led; 
//         end 
//     end
// endmodule