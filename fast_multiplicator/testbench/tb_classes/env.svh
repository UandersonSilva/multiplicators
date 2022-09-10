class env;
    transaction_port #(input_transaction) env_tp_in;
    transaction_port #(output_transaction) env_tp_out;
    mailbox #(data_item) data_mbox;

    driver         driver_r;
    scoreboard     scoreboard_r;
    input_monitor  input_monitor_r;
    output_monitor output_monitor_r;

    virtual fast_multiplicator_interface fm_if;

    function new();
        env_tp_in  = new();
        env_tp_out = new();
        
        driver_r         = new();
        scoreboard_r     = new();
        input_monitor_r  = new();
        output_monitor_r = new();
    endfunction : new

    task run();
        fm_if.input_monitor_r  = input_monitor_r;
        fm_if.output_monitor_r = output_monitor_r;
        
        driver_r.fm_if = fm_if;

        driver_r.data_mbox = data_mbox;

        input_monitor_r.monitor_tp  = env_tp_in;
        output_monitor_r.monitor_tp = env_tp_out;

        scoreboard_r.scoreboard_tp_in  = env_tp_in;
        scoreboard_r.scoreboard_tp_out = env_tp_out;

        scoreboard_r.input_read = fm_if.input_read;
        scoreboard_r.output_read = fm_if.output_read;

        fork
            driver_r.run();
            scoreboard_r.run();
        join_any
            
    endtask : run

endclass : env