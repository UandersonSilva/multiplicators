class output_transaction;
    logic signed [2*WIDTH - 1:0] product_out;
    logic overflow_out;

    function bit compare(output_transaction compared);
        bit same = 0;
        if(compared == null)
            $display("%0t [OUTPUT TRANSACTION]: Null pointer. Comparison aborted.", $time);
        else
            same = (compared.product_out == product_out) && 
                   (compared.overflow_out == overflow_out);

        return same;
    endfunction : compare

    function void copy(output_transaction copied);
        product_out  = copied.product_out;
        overflow_out = copied.overflow_out;
    endfunction : copy

    function output_transaction clone();
        output_transaction cloned;
        cloned = new();

        cloned.product_out  = product_out;
        cloned.overflow_out = overflow_out;

        return cloned;
    endfunction : clone

    function string convert2string();
        string s;
        s = $sformatf("product_out: %2d overflow_out: %b", product_out, overflow_out);

        return s;
    endfunction : convert2string

endclass : output_transaction