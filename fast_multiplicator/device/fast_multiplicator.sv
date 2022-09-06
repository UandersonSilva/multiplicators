`include "alu_c.sv"
`include "number_complementer.sv"

module fast_multiplicator #(
        parameter WIDTH = 16
    )(
        input [WIDTH-1:0] multiplicand_in,
        input [WIDTH-1:0] multiplier_in,
        output [2*WIDTH-1:0] product_out,
        output overflow_out
    );

    logic [WIDTH-1:0] alu_a [WIDTH-2:0];
    logic [WIDTH-1:0] alu_b [WIDTH-2:0];
    logic [WIDTH-3:0] alu_co;
    logic [WIDTH-1:0] multiplicand, multiplier;
    logic [2*WIDTH-1:0] product;

    initial
    begin
        if(WIDTH < 4)
        begin
            $fatal("WIDTH must be greater or equal to 4.");
        end
    end

    number_complementer #(WIDTH) multiplicand_comp(
        .number_in(multiplicand_in),
        .complement_in(multiplicand_in[WIDTH-1]),
        .number_out(multiplicand)
    );

    number_complementer #(WIDTH) multiplier_comp(
        .number_in(multiplier_in),
        .complement_in(multiplier_in[WIDTH-1]),
        .number_out(multiplier)
    );

    assign alu_b[0] = multiplicand & {WIDTH{multiplier[0]}};
    assign alu_a[0] = multiplicand & {WIDTH{multiplier[1]}};
    assign product[0] = alu_b[0][0];

    alu_c #(WIDTH) alu_c0(
        .alu_A_in(alu_a[0]),
        .alu_B_in({1'b0, alu_b[0][WIDTH-1:1]}),
        .alu_op_in(1'b0),
        .alu_out(alu_b[1]),
        .alu_Z_out(),
        .alu_N_out(),
        .alu_C_out(alu_co[0])
    );

    generate
        genvar i;

        for(i = 1; i < WIDTH - 2; i++)
        begin
            assign alu_a[i] = multiplicand & {WIDTH{multiplier[i+1]}};
            assign product[i] = alu_b[i][0];

            alu_c #(WIDTH) alu_cn(
                .alu_A_in(alu_a[i]),
                .alu_B_in({alu_co[i-1], alu_b[i][WIDTH-1:1]}),
                .alu_op_in(1'b0),
                .alu_out(alu_b[i+1]),
                .alu_Z_out(),
                .alu_N_out(),
                .alu_C_out(alu_co[i])
            );
        end
    endgenerate

    assign alu_a[WIDTH-2] = multiplicand & {WIDTH{multiplier[WIDTH-1]}};
    assign product[WIDTH-2] = alu_b[WIDTH-2][0];

    alu_c #(WIDTH) alu_cl(
        .alu_A_in(alu_a[WIDTH-2]),
        .alu_B_in({alu_co[WIDTH-3], alu_b[WIDTH-2][WIDTH-1:1]}),
        .alu_op_in(1'b0),
        .alu_out(product[2*WIDTH-2:WIDTH-1]),
        .alu_Z_out(),
        .alu_N_out(),
        .alu_C_out(product[2*WIDTH-1])
    );

    assign overflow_out = product[2*WIDTH-1];

    number_complementer #(2*WIDTH) product_comp(
        .number_in(product),
        .complement_in(multiplicand_in[WIDTH-1]^multiplier_in[WIDTH-1]),
        .number_out(product_out)
    );

endmodule