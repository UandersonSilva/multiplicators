`include "alu.sv"
`include "number_complementer.sv"
`include "register.sv"
`include "shift_register.sv"
`include "sm_control.sv"

module sequential_multiplicator #(
        parameter WIDTH = 16
    )(
        input logic [WIDTH - 1:0] multiplicand_in,
        input logic [WIDTH - 1:0] multiplier_in,
        input logic clock, reset_in, start_in,
        output logic [2*WIDTH - 1:0] product_out,
        output logic done_out, overflow_out
    );

    logic [WIDTH - 1:0] multiplicand_nc, multiplier_nc, multiplier_0;
    logic [2*WIDTH - 1:0] multiplicand_0, product_0, product_in;
    logic multiplicand_comp, multiplicand_wr;
    logic [1:0] multiplicand_shift, signal_bit_0;
    logic multiplier_comp, multiplier_wr;
    logic signal_bit_wr, product_wr;
    logic multiplicand_reset, multiplier_reset;
    logic product_reset, signal_bit_reset, product_comp;
  

    number_complementer #(WIDTH) multiplicand_complementer( 
        .number_in(multiplicand_in), 
        .complement_in(multiplicand_comp), 
        .number_out(multiplicand_nc)
    );

    shift_register #(2*WIDTH) multiplicand_register( 
        .reg_in({{WIDTH{1'b0}}, multiplicand_nc}), 
        .reg_wr(multiplicand_wr), 
        .reg_reset(multiplicand_reset),
        .clock(clock),
        .shift_in(multiplicand_shift),
        .reg_out(multiplicand_0)
    );

    number_complementer #(WIDTH) multiplier_complementer( 
        .number_in(multiplier_in), 
        .complement_in(multiplier_comp), 
        .number_out(multiplier_nc)
    );

    register #(WIDTH) multiplier_register(
        .reg_in(multiplier_nc), 
        .reg_wr(multiplier_wr), 
        .reg_reset(multiplier_reset), 
        .clock(clock), 
        .reg_out(multiplier_0)
    );

    register #(2) signal_bit_register(
        .reg_in({multiplicand_in[WIDTH-1], multiplier_in[WIDTH-1]}), 
        .reg_wr(signal_bit_wr), 
        .reg_reset(signal_bit_reset), 
        .clock(clock), 
        .reg_out(signal_bit_0)
    );

    alu #(2*WIDTH) alu_32(
        .alu_A_in(multiplicand_0), 
        .alu_B_in(product_0),
        .alu_op_in(1'b0),
        .alu_out(product_in),
        .alu_Z_out(), 
        .alu_N_out()
    );

    register #(2*WIDTH) product_register(
        .reg_in(product_in), 
        .reg_wr(product_wr), 
        .reg_reset(product_reset), 
        .clock(clock), 
        .reg_out(product_0)
    );

    number_complementer #(2*WIDTH) product_complementer( 
        .number_in(product_0), 
        .complement_in(product_comp), 
        .number_out(product_out)
    );

    sm_control #(WIDTH) smc0(
        .start_in(start_in), 
        .product_msb_in(product_0[2*WIDTH-1]), 
        .clock(clock), 
        .reset_in(reset_in),
        .signal_bit_in(signal_bit_0),
        .multiplier_in(multiplier_0),
        .multiplicand_comp_out(multiplicand_comp), 
        .multiplicand_wr_out(multiplicand_wr),
        .multiplicand_shift_out(multiplicand_shift),
        .multiplier_comp_out(multiplier_comp), 
        .multiplier_wr_out(multiplier_wr),
        .signal_bit_wr_out(signal_bit_wr), 
        .product_wr_out(product_wr),
        .multiplicand_reset_out(multiplicand_reset), 
        .multiplier_reset_out(multiplier_reset),
        .product_reset_out(product_reset), 
        .signal_bit_reset_out(signal_bit_reset),
        .product_comp_out(product_comp),
        .done_out(done_out), 
        .overflow_out(overflow_out)
    );
endmodule