class output_transaction;
    logic signed [WIDTH - 1:0] quotient_out, remainder_out;
    logic dbz_out;

    function bit compare(output_transaction compared);
        bit same = 0;
        
        if(compared == null)
            $display("%0t [OUTPUT TRANSACTION]: Null pointer. Comparison aborted.", $time);
        else
        begin
            same = same && 
                   (compared.quotient_out == quotient_out) &&
                   (compared.remainder_out == remainder_out) && 
                   (compared.dbz_out == dbz_out);
        end

        return same;
    endfunction : compare

    function void copy(output_transaction copied);
        quotient_out  = copied.quotient_out;
        remainder_out = copied.remainder_out;
        dbz_out       = copied.dbz_out;
    endfunction : copy

    function output_transaction clone();
        output_transaction cloned;
        cloned = new();

        cloned.quotient_out  = quotient_out;
        cloned.remainder_out = remainder_out;
        cloned.dbz_out       = dbz_out;

        return cloned;
    endfunction : clone

    function string convert2string_b();
        string s;
        s = $sformatf("quotient_out: %16b remainder_out: %16b dbz_out: %b", quotient_out, remainder_out, dbz_out);

        return s;
    endfunction : convert2string_b

    function string convert2string();
        string s;
        s = $sformatf("quotient_out: %0d remainder_out: %0d dbz_out: %b", quotient_out, remainder_out, dbz_out);

        return s;
    endfunction : convert2string

endclass : output_transaction