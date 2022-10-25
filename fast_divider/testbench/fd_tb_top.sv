`include "../device/fast_divider.sv"
`include "fd_tb_pkg.sv"
`include "fd_interface.sv"

module fd_tb_top;
    import fd_tb_pkg::*;

    fd_interface fd_if();

    fast_divider #(WIDTH) fd0(
        .dividend_in(fd_if.dividend_in), 
        .divisor_in(fd_if.divisor_in), 
        .quotient_out(fd_if.quotient_out),
        .remainder_out(fd_if.remainder_out),
        .dbz_out(fd_if.dbz_out)
    );

    initial
    begin
        string test_name;

        base_test t0;
        
        $value$plusargs("TEST=%s", test_name);

        case(test_name)
            "INITIAL_TEST":
            begin
                initial_test selected;
                selected = new();
                t0 = selected;
            end
            
            "RANDOM_TEST":
            begin
                random_test selected;
                selected = new();
                t0 = selected;
            end

        //    "FACTORIAL_TEST":
        //    begin
        //        factorial_test selected;
        //        selected = new();
        //        t0 = selected;
        //    end

        //    "OFUF_TEST":
        //    begin
        //        ofuf_test selected;
        //        selected = new();
        //        t0 = selected;
        //    end

            default:
            begin
                random_test selected;
                selected = new();
                t0 = selected;
                test_name = $sformatf("DEFAULT(RANDOM_TEST)");
            end
        endcase

        t0.env_r.fd_if = fd_if;

        $display("%c[2;35m", 27, "[TB_TOP] Running %s", test_name);
        $display("%c[0m", 27);
        
        t0.run();
        #5;
        $finish;
    end
endmodule : fd_tb_top