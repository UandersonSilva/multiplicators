class input_transaction;
    logic signed [WIDTH - 1:0] multiplicand_in, multiplier_in;
    logic start_in, reset_in;

    function bit compare(input_transaction compared);
        bit same = 0;
        if(compared == null)
            $display("[INPUT TRANSACTION]: Null pointer. Comparison aborted.");
        else
            same = (compared.multiplicand_in == multiplicand_in) &&
                   (compared.multiplier_in == multiplier_in) &&
                   (compared.start_in == start_in) &&
                   (compared.reset_in == reset_in);

        return same;
    endfunction : compare

    function void copy(input_transaction copied);
        multiplicand_in = copied.multiplicand_in;
        multiplier_in   = copied.multiplier_in;
        start_in        = copied.start_in;
        reset_in        = copied.reset_in;
    endfunction : copy

    function input_transaction clone();
        input_transaction cloned;
        cloned = new();

        cloned.multiplicand_in = multiplicand_in;
        cloned.multiplier_in   = multiplier_in;
        cloned.start_in        = start_in;
        cloned.reset_in        = reset_in;

        return cloned;
    endfunction : clone

    function string convert2string();
        string s;
        s = $sformatf("multiplicand_in: %2d multiplier_in: %2d start_in: %b reset_in: %b", multiplicand_in, multiplier_in, start_in, reset_in);

        return s;
    endfunction : convert2string

endclass : input_transaction