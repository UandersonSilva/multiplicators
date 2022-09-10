class input_monitor;
    transaction_port #(input_transaction) monitor_tp;

    function void read(logic signed [WIDTH - 1:0] multiplicand_in, logic signed [WIDTH - 1:0] multiplier_in);
        input_transaction t_in;
        t_in = new();

        t_in.multiplicand_in = multiplicand_in;
        t_in.multiplier_in   = multiplier_in;

        monitor_tp.write(t_in);
    endfunction : read
endclass : input_monitor