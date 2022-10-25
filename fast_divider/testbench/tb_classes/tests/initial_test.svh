class initial_test extends base_test;
    task run;
        super.run();

        data_i = new();
        data_i.dividend_in = 16'd35;
        data_i.divisor_in = 16'd35;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = 16'd35;
        data_i.divisor_in = 16'd1;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = 16'd35;
        data_i.divisor_in = 16'd5;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = ~(16'd35)+16'd1;
        data_i.divisor_in = 16'd5; 
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = ~(16'd35)+16'd1;
        data_i.divisor_in = ~(16'd5)+16'd1; 
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = 16'd35;
        data_i.divisor_in = ~(16'd5)+16'd1; 
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = 16'd35;
        data_i.divisor_in = 16'd4;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = ~(16'd35)+16'd1;
        data_i.divisor_in = 16'd4; 
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = ~(16'd35)+16'd1;
        data_i.divisor_in = ~(16'd4)+16'd1; 
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = 16'd35;
        data_i.divisor_in = ~(16'd4)+16'd1; 
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();

        data_i = new();
        data_i.dividend_in = 16'd35;
        data_i.divisor_in = 16'd0;
        super.insert_data();
      
        @(data_i.done);

        super.obtain_data();
    endtask : run
endclass : initial_test