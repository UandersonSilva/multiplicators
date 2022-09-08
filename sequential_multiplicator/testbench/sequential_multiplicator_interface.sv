interface sequential_multiplicator_interface();
    import sequential_multiplicator_tb_pkg::*;

    logic [WIDTH - 1:0] multiplicand_in, multiplier_in; 
    logic start_in, reset_in, done_out, clock, overflow_out;
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
            logic srt, logic rst,
            logic [2*WIDTH - 1:0] prod_out,
            logic overflow
        );
        multiplicand_in = mnd_in;
        multiplier_in = mtr_in;
        start_in = srt;
        reset_in = rst;

        if(start_in)
            @(posedge done);
        else 
            @(posedge clock);
        #2;
        prod_out = product_out;
        overflow = overflow_out;
    endtask : send_data

    always @(posedge start or negedge reset)
    begin : input_monitor_read
        #2;
        input_monitor_r.read(multiplicand_in, multiplier_in, start_in, reset_in);
        -> input_read;
    end

    always @(posedge start or negedge reset)
    begin : output_monitor_read
        if(start_in)
            @(posedge done);
        else 
            @(posedge clock);
        #2;
        output_monitor_r.read(product_out, overflow_out);
        -> output_read;
    end
endinterface : sequential_multiplicator_interface