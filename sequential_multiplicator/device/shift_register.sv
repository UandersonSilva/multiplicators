module shift_register #(
    parameter WIDTH = 16
)
(
    input logic [WIDTH - 1:0] reg_in, 
    input logic reg_wr, reg_reset, clock,
    input logic [1:0] shift_in, 
    output logic [WIDTH - 1:0] reg_out
);
    localparam
        _NONE_1 = 2'b11,
        _LEFT   = 2'b10,
        _RIGHT  = 2'b01,
        _NONE_0 = 2'b00;

    always_ff @(posedge clock or posedge reg_reset)
    begin
        if(reg_reset==1'b1)
            reg_out <= {WIDTH{1'b0}};
        else
        begin
            if (reg_wr == 1'b1)
                reg_out <= reg_in;
            else
            begin
                case(shift_in)
                    _LEFT:
                        reg_out <= reg_out << 1;
                    _RIGHT:
                        reg_out <= reg_out >> 1;
                    default:
                        reg_out <= reg_out;
                endcase
            end
        end
    end
endmodule