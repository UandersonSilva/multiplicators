class output_monitor;
    transaction_port #(output_transaction) monitor_tp;
    
    function void read(logic [WIDTH - 1:0] quotient_out, logic [WIDTH - 1:0] remainder_out, logic dbz_out);
        output_transaction t_out;
        t_out = new();

        t_out.quotient_out  = quotient_out;
        t_out.remainder_out = remainder_out;
        t_out.dbz_out = dbz_out;

        monitor_tp.write(t_out);
    endfunction : read
endclass : output_monitor