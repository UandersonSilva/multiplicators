class output_monitor;
    transaction_port #(output_transaction) monitor_tp;
    
    function void read(logic signed [2*WIDTH - 1:0] product_out, logic overflow_out);
        output_transaction t_out;
        t_out = new();

        t_out.product_out  = product_out;
        t_out.overflow_out = overflow_out;

        monitor_tp.write(t_out);
    endfunction : read
endclass : output_monitor