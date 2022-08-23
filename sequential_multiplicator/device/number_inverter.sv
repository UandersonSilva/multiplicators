module number_inverter #(
    parameter DATA_WIDTH = 16
)(
    input logic [DATA_WIDTH - 1:0] number_in,
    input logic invert_in,
    output logic [DATA_WIDTH - 1:0] number_out
);
    always_comb
    begin
        if(invert_in)
            number_out = ~(number_in) + 1'b1;
        else
            number_out = number_in;
    end
endmodule