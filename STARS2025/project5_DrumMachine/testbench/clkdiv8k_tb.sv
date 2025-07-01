`timescale 1ms/10ns
module clkdiv8k_tb;
    logic clk, rst, en, newclk;
    logic newclk_exp, count_exp;
    clkdiv8k eightk (.clk(clk), .rst(rst), .newclk(newclk)); 

    integer test_case = 0;

    always begin
        #1
        clk = ~clk;
    end

    task reset();
        begin
            rst = 1;
            #8
            rst = 0;
        end
    endtask

    task compare(int expected, int actual);
    begin
        if (expected == actual) begin
            $display("PASSED test case %d", test_case);
        end else begin
            $display("FAILED test case %d\n expected = %d, actual = %d", test_case, expected, actual);
        end
    end
    endtask

    initial begin
        $dumpfile("waves/clkdiv8k.vcd");
        $dumpvars(0, clkdiv8k_tb);

        // Initialize all inputs
        clk = 0;
        en = 1;

        //power on reset
        test_case = 1;
        newclk_exp = 0;
        reset();
        compare(newclk_exp, newclk);
        #8

        //disabled
        test_case = 2;
        en = 0;
        #8
        compare(newclk_exp, newclk);

        //normal operation
        test_case = 3;
        en = 1;
        reset();
        repeat (100) #2;
        newclk_exp = 1;
        compare(newclk_exp, newclk);
        repeat (100) #2;
        newclk_exp = 0;
        compare(newclk_exp, newclk);
        repeat (100) #2;
        newclk_exp = 1;
        compare(newclk_exp, newclk);
        #10

        //mid-operation reset
        test_case = 4;
        #20
        rst = 1;
        #8
        newclk_exp = 0;
        compare(newclk_exp, newclk);
        #5
        $finish;
    end

endmodule