class random_test extends base_test;
    task run;
        super.run();
      
        repeat(9)
        begin            
            data_i = new();

            assert(data_i.randomize());
            
            super.insert_data();

            @(data_i.done);

            super.obtain_data();
        end
    endtask : run
endclass : random_test