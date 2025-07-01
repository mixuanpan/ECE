module ledshift (
   input logic clk, rst, en, 
   output logic [15:0] led, 
   output logic readin_en 
);


logic [15:0] n_led; 

always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
        led <= '1;
    end else begin 
        led <= n_led;
    end
end

always_comb begin 
    readin_en = 1'b0; 
    n_led = '1;
    if (en) begin 
        n_led = led >> 1;
    end

    if (led[1]) begin 
        if(led[0]) begin 
            readin_en = 1'b1; 
        end
    end
end

endmodule
