class input_monitor;
    transaction_port #(input_transaction) monitor_tp;

    function void read(logic [WIDTH - 1:0] dividend_in, logic [WIDTH - 1:0] divisor_in);
        input_transaction t_in;
        t_in = new();

        t_in.dividend_in = dividend_in;
        t_in.divisor_in = divisor_in;

        monitor_tp.write(t_in);
    endfunction : read
endclass : input_monitor