class driver;
    virtual sequential_multiplicator_interface sm_if;
    mailbox #(data_item) data_mbox;

    task run();
        data_item data_i;

        forever
        begin
            data_mbox.get(data_i);
            
            @(negedge sm_if.clock);
            #1;
            if(data_i == null)
                $display("%0t [DRIVER]: No data item.", $time);
            else
            begin
                reg_if.send_data(data_i.multiplicand_in, 
                                 data_i.multiplier_in, 
                                 data_i.start_in, 
                                 data_i.reset_in, 
                                 data_i.product_out, 
                                 data_i.overflow_out
                                );
                ->data_i.done;
            end
        end
    endtask : run

endclass : driver