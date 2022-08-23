module register#(
        parameter WIDTH = 16
    )
    (
        input logic [WIDTH - 1:0] reg_in, 
        input logic reg_wr, reg_reset, clock, 
        output logic [WIDTH - 1:0] reg_out
    );

    always_ff @(posedge clock or posedge reg_reset)
    begin
        if(reg_reset==1'b1)
            reg_out <= {WIDTH{1'b0}};
        else
        begin
            if (reg_wr == 1'b1)
                reg_out <= reg_in;
        end
    end

endmodule