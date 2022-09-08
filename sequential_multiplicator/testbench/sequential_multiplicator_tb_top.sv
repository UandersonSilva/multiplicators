`include "../device/sequential_multiplicator.sv"
`include "sequential_multiplicator_tb_pkg.sv"
`include "sequential_multiplicator_interface.sv"


module sequential_multiplicator_tb_top;
    import sequential_multiplicator_tb_pkg::*;

    sequential_multiplicator_interface sm_if();

    sequential_multiplicator sm0(
        .multiplicand_in(sm_if.multiplicand_in), 
        .multiplier_in(sm_if.multiplier_in),
        .start_in(sm_if.start_in),
        .reset_in(sm_if.reset_in),
        .clock(sm_if.clock), 
        .product_out(sm_if.product_out),
        .overflow_out(sm_if.overflow_out),
        .done_out(sm_if.done_out)
    );

    random_test t0;

    initial
    begin
        t0 = new();
        t0.env_r.sm_if = sm_if;
        t0.run();
        #20;
        $finish;
    end
endmodule : sequential_multiplicator_tb_top