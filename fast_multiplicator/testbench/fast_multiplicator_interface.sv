interface fast_multiplicator_interface();
    import fast_multiplicator_tb_pkg::*;

    logic [WIDTH - 1:0] multiplicand_in, multiplier_in; 
    logic clock, overflow_out;
    logic [2*WIDTH - 1:0] product_out;

    input_monitor  input_monitor_r;
    output_monitor output_monitor_r;

    event input_read;
    event output_read;

    initial
    begin
        clock = 0;
        forever 
        begin
           #10;
           clock = ~clock;
        end
    end

    task send_data(
            logic [WIDTH - 1:0] mnd_in,
            logic [WIDTH - 1:0] mtr_in,
            logic [2*WIDTH - 1:0] prod_out,
            logic overflow
        );
        @(clock);
       
        multiplicand_in = mnd_in;
        multiplier_in = mtr_in;
        
        #2;
        prod_out = product_out;
        overflow = overflow_out;
    endtask : send_data

    always @(clock)
    begin : input_monitor_read
        #1;
        input_monitor_r.read(multiplicand_in, multiplier_in);
        -> input_read;
    end

    always @(clock)
    begin : output_monitor_read
        #2;
        output_monitor_r.read(product_out, overflow_out);
        -> output_read;
    end
endinterface : fast_multiplicator_interface