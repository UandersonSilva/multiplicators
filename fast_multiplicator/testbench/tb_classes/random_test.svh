class random_test extends base_test;
    task run;
        super.run();
      
        repeat(9)
        begin            
            data_i = new();

            assert(data_i.randomize());
            super.insert_data();

            @(data_i.done);
        end

        data_i = new();
        data_i.multiplicand_in = 0;
        data_i.multiplier_in = 0;
        super.insert_data();
      
        @(data_i.done);
    endtask : run
endclass : random_test