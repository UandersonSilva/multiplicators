class base_test;
    mailbox #(data_item) data_mbox;
    data_item data_i;
    
    env env_r;

    function new();
        data_mbox = new();
        env_r     = new();
    endfunction : new

    task insert_data();
        if(data_i == null)
            $display("%0t [TEST]: No data item inserted.", $time);
        else
            data_mbox.put(data_i);
    endtask : insert_data

    virtual task run();
        env_r.data_mbox = data_mbox;
        fork
            env_r.run();
        join_none
    endtask : run
endclass : base_test