class driver;
    virtual fd_interface fd_if;
    mailbox #(data_item) data_mbox;

    task run();
        data_item data_i;

        forever
        begin
            data_mbox.get(data_i);
            
            #1;
            if(data_i == null)
                $display("%0t [DRIVER]: No data item.", $time);
            else
            begin
                fd_if.send_data(data_i.dividend_in, 
                                 data_i.divisor_in,  
                                 data_i.quotient_out, 
                                 data_i.remainder_out,
                                 data_i.dbz_out
                                );
                ->data_i.done;

                @(data_i.done);
            end
        end
    endtask : run

endclass : driver