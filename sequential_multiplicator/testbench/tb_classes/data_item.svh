class data_item;
    rand logic signed [WIDTH - 1:0] multiplicand_in, multiplier_in;
    logic start_in, reset_in;
    logic signed [2*WIDTH - 1:0] product_out;
    logic overflow_out;

    event done;

    function bit compare(data_item compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [DATA ITEM]: Null pointer. Comparison aborted.", $time);
        else
            same = (compared.multiplicand_in == multiplicand_in) &&
                   (compared.multiplier_in == multiplier_in) &&
                   (compared.start_in == start_in) &&
                   (compared.reset_in == reset_in) &&
                   (compared.product_out == product_out) && 
                   (compared.overflow_out == overflow_out);

        return same;
    endfunction : compare

    function void copy(data_item copied);
        multiplicand_in = copied.multiplicand_in;
        multiplier_in   = copied.multiplier_in;
        start_in        = copied.start_in;
        reset_in        = copied.reset_in;
        product_out     = copied.product_out;
        overflow_out    = copied.overflow_out;
    endfunction : copy

    function data_item clone();
        data_item cloned;
        cloned = new();

        cloned.multiplicand_in = multiplicand_in;
        cloned.multiplier_in   = multiplier_in;
        cloned.start_in        = start_in;
        cloned.reset_in        = reset_in;
        cloned.product_out     = product_out;
        cloned.overflow_out    = overflow_out;

        return cloned;
    endfunction : clone

    function string convert2string();
        string s;
        s = $sformatf("multiplicand_in: %2d multiplier_in: %2d start_in: %b reset_in: %b => product_out: %2d overflow_out: %b",
                        multiplicand_in, multiplier_in, start_in, reset_in,
                        product_out, overflow_out);

        return s;
    endfunction : convert2string

endclass : data_item