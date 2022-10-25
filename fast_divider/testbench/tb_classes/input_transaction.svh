class input_transaction;
    logic signed [WIDTH - 1:0] dividend_in, divisor_in;

    function bit compare(input_transaction compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [INPUT TRANSACTION]: Null pointer. Comparison aborted.", $time);
        else
            same = (compared.dividend_in == dividend_in) &&
                   (compared.divisor_in == divisor_in);
        return same;
    endfunction : compare

    function void copy(input_transaction copied);
        dividend_in = copied.dividend_in;
        divisor_in = copied.divisor_in;
    endfunction : copy

    function input_transaction clone();
        input_transaction cloned;
        cloned = new();

        cloned.dividend_in = dividend_in;
        cloned.divisor_in = divisor_in;

        return cloned;
    endfunction : clone

    function string convert2string_b();
        string s;
        s = $sformatf("dividend_in: %16b divisor_in: %16b", dividend_in, divisor_in);

        return s;
    endfunction : convert2string_b

    function string convert2string();
        string s;
        s = $sformatf("dividend_in: %0d divisor_in: %0d", dividend_in, divisor_in);

        return s;
    endfunction : convert2string

endclass : input_transaction