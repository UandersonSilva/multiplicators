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
                predicted.quotient_out  = t_in.dividend_in / t_in.divisor_in;
                predicted.remainder_out = t_in.dividend_in % t_in.divisor_in;
                predicted.dbz_out = (t_in.divisor_in == 0) ? 1'b1 : 1'b0;
                
                $display("%0t", $time, {" [SCOREBOARD]: INPUT:: ", t_in.convert2string()});
            end

            @(output_read);
            scoreboard_tp_out.read(t_out);

            if(t_out == null)
                $display("%0t [SCOREBOARD]: No output transaction. Null pointer.", $time);
            else
            begin
                if(predicted.compare(t_out))
                begin
                    //$write("%c[2;34m",27);//blue
                    $display("%c[2;34m", 27, "%0t", $time, {" [SCOREBOARD]: PASS:: ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});
                    $write("%c[2;0m",27);//standard color
                end
                else
                begin
                    //$display("%c[2;31m",27);//red
                    $display("%c[2;31m", 27, "%0t", $time, {" [SCOREBOARD]: FAIL:: ", t_out.convert2string(), " || Predicted => ", predicted.convert2string()});
                    $write("%c[2;0m",27);//standard color
                end
            end
        end
    endtask : run
endclass : scoreboard