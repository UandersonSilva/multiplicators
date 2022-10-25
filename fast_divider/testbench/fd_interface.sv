interface fd_interface();
    import fd_tb_pkg::*;

    logic [WIDTH - 1:0] dividend_in, divisor_in;
    logic [WIDTH - 1:0] quotient_out, remainder_out;
    logic dbz_out, clock;

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
            input logic [WIDTH - 1:0] idividend_in,
            input logic [WIDTH - 1:0] idivisor_in,
            output logic [WIDTH - 1:0] iquotient_out,
            output logic [WIDTH - 1:0] iremainder_out,
            output logic dbz
        );
        @(clock);
       
        dividend_in = idividend_in;
        divisor_in  = idivisor_in;
        
        #2;
        iquotient_out  = quotient_out;
        iremainder_out = remainder_out;
        dbz = dbz_out;
    endtask : send_data

    always @(clock)
    begin : input_monitor_read
        #1;
        input_monitor_r.read(dividend_in, divisor_in);
        -> input_read;
    end

    always @(clock)
    begin : output_monitor_read
        #2;
        output_monitor_r.read(quotient_out, remainder_out, dbz_out);
        -> output_read;
    end
endinterface : fd_interface