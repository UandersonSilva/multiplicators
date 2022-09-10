`include "../device/fast_multiplicator.sv"
`include "fast_multiplicator_tb_pkg.sv"
`include "fast_multiplicator_interface.sv"


module fast_multiplicator_tb_top;
    import fast_multiplicator_tb_pkg::*;

    fast_multiplicator_interface fm_if();

    fast_multiplicator fm0(
        .multiplicand_in(fm_if.multiplicand_in), 
        .multiplier_in(fm_if.multiplier_in), 
        .product_out(fm_if.product_out),
        .overflow_out(fm_if.overflow_out)
    );

    random_test t0;

    initial
    begin
        t0 = new();
        t0.env_r.fm_if = fm_if;
        t0.run();
        #20;
        $finish;
    end
endmodule : fast_multiplicator_tb_top