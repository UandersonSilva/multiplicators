class scoreboard;
    transaction_port #(input_transaction) scoreboard_tp_in;
    transaction_port #(output_transaction) scoreboard_tp_out;

    event input_read;
    event output_read;

    task run();
        input_transaction  t_in;
        output_transaction t_out, predicted;

        forever 
        begin
            predicted = new();

            @(input_read);
            scoreboard_tp_in.read(t_in);

            if(t_in == null)
                $display("%0t [SCOREBOARD]: No input transaction. Null pointer.", $time);
            else
            begin
                if(t_in.start_in)
                begin
                    predicted.product_out = t_in.multiplicand_in * t_in.multiplier_in;
                    predicted.overflow_out = 
                end
                else if(!t_in.reset_in)
                begin
                    predicted.product_out = {WIDTH{1'b0}};
                    predicted.overflow_out = 1'b0;
                end
            end

            @(output_read);
            scoreboard_tp_out.read(t_out);

            if(t_out == null)
                $display("%0t [SCOREBOARD]: No output transaction. Null pointer.", $time);
            else
            begin
                if(t_out.compare(predicted))
                    $display("%0t", $time, {" [SCOREBOARD]: PASS:: ", t_in.convert2string(), 
                    " => ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});
                else
                    $display("%0t", $time, {"% [SCOREBOARD]: FAIL:: ", t_in.convert2string(), 
                    " => ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});
            end
        end
    endtask : run
endclass : scoreboard