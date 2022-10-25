class data_item;
    rand logic signed [WIDTH - 1:0] dividend_in, divisor_in;;
    logic signed [WIDTH - 1:0] quotient_out, remainder_out;
    logic dbz_out;

    event done;

    function bit compare(data_item compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [DATA ITEM]: Null pointer. Comparison aborted.", $time);
        else
            same = (compared.dividend_in == dividend_in) &&
                   (compared.divisor_in == divisor_in) && 
                   (compared.quotient_out == quotient_out) &&
                   (compared.remainder_out == remainder_out) && 
                   (compared.dbz_out == dbz_out);

        return same;
    endfunction : compare

    function void copy(data_item copied);
        dividend_in   = copied.dividend_in;
        divisor_in    = copied.divisor_in;
        quotient_out  = copied.quotient_out;
        remainder_out = copied.remainder_out;
        dbz_out       = copied.dbz_out;
    endfunction : copy

    function data_item clone();
        data_item cloned;
        cloned = new();

        cloned.dividend_in   = dividend_in;
        cloned.divisor_in    = divisor_in;
        cloned.quotient_out  = quotient_out;
        cloned.remainder_out = remainder_out;
        cloned.dbz_out       = dbz_out;

        return cloned;
    endfunction : clone

    function string convert2string_b();
        string s;
        s = $sformatf("dividend_in: %16b divisor_in: %16b => quotient_out: %16b remainder_out: %16b dbz_out: %b",
                    dividend_in, divisor_in, quotient_out, remainder_out, dbz_out);

        return s;
    endfunction : convert2string_b

    function string convert2string();
        string s;
        s = $sformatf("dividend_in: %0d divisor_in: %0d => quotient_out: %0d remainder_out: %0d dbz_out: %b",
                    dividend_in, divisor_in, quotient_out, remainder_out, dbz_out);

        return s;
    endfunction : convert2string

endclass : data_item