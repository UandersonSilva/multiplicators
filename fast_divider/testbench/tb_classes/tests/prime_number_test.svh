class prime_number_test extends base_test;
    task run;
        int prime_count;

        super.run();

        for(int i = 1; i<=11; i++)
        begin
            prime_count = 0;

            for(int j = 1; j<=i; j++)
            begin                
                data_i = new();
                data_i.dividend_in = 16'(i);
                data_i.divisor_in = 16'(j);

                super.insert_data();
        
                @(data_i.done);

                super.obtain_data();

                if(previous_data.remainder_out == 16'd0)
                    prime_count++;
            end

            if(prime_count==2)
            begin
                $write("%c[2;32m", 27);//green color
                $display("%0t", $time, " [TEST]: %0d ::PRIME NUMBER::", previous_data.dividend_in);
                $write("%c[2;0m",27);//standard color
            end
        end
    endtask : run
endclass : prime_number_test