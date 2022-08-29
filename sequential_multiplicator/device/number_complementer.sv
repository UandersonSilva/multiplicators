module number_complementer #(
    parameter DATA_WIDTH = 16
)(
    input logic [DATA_WIDTH - 1:0] number_in,
    input logic complement_in,
    output logic [DATA_WIDTH - 1:0] number_out
);
    always_comb
    begin
        if(complement_in)
            number_out = ~(number_in) + 1'b1;
        else
            number_out = number_in;
    end
endmodule