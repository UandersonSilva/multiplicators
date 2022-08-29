module sm_control #(
    WIDTH = 16
)(
    input logic start_in, product_msb_in, clock, reset_in,
    input logic [1:0] signal_bit_in,
    input logic [WIDTH - 1:0] multiplier_in,
    output logic multiplicand_inv_out, multiplicand_wr_out,
    output logic [1:0] multiplicand_shift_out,
    output logic multiplier_inv_out, multiplier_wr_out,
    output logic signal_bit_wr_out, product_wr_out,
    output logic multiplicand_reset_out, multiplier_reset_out,
    output logic product_reset_out, signal_bit_reset_out,
    output logic product_inv_out,
    output logic done_out, overflow_out

);
    localparam 
        _IDLE = 2'b00,
        _RESET = 2'b01,
        _INVERT = 2'b10,
        _PRODUCT_INCREMENT = 2'b11;

    logic [1:0] current_state, next_state = _RESET;
    logic signal_bit_read = 1'b0, mult_finished = 1'b1, mult_rq = 1'b0, shift = 1'b0;
    int pos = 0;
    
    always_ff @(posedge start_in or posedge mult_finished or negedge reset_in) 
    begin
        if(!reset_in)
            mult_rq <= 1'b0;
		else
        begin
            if(mult_finished)
                mult_rq <= !mult_rq;
            else
                mult_rq <= 1'b1;
        end
    end
		
	always_ff @(negedge clock or negedge reset_in)
	begin
        if(!reset_in)
			current_state <= _RESET;
		else
			current_state <= next_state;
	end

    always_comb
	begin
		case(current_state)		
			_IDLE:
			begin
                if(mult_rq)
				    next_state <= _RESET;
                else
                    next_state <= _IDLE;
			end	
			
			_RESET: 
			begin
                if(mult_rq)
				    next_state <= _INVERT;
                else
                    next_state <= _IDLE;
			end

			_INVERT:
			begin
                if(signal_bit_read)
				    next_state <= _PRODUCT_INCREMENT;
                else
                    next_state <= _INVERT;
			end

            _PRODUCT_INCREMENT:
			begin
                if(mult_finished)
				    next_state <= _IDLE;
                else
                    next_state <= _PRODUCT_INCREMENT;
			end
		endcase
	end

  always_ff @(negedge clock)
    begin
        case(current_state)
            _IDLE:
            begin
                multiplicand_inv_out   <= 1'b0;
                multiplicand_wr_out    <= 1'b0;
                multiplicand_shift_out <= 2'b00;
                multiplier_inv_out     <= 1'b0; 
                multiplier_wr_out      <= 1'b0;
                signal_bit_wr_out      <= 1'b0;
                product_wr_out         <= 1'b0;
                multiplicand_reset_out <= 1'b0;
                multiplier_reset_out   <= 1'b0;
                product_reset_out      <= 1'b0;
                signal_bit_reset_out   <= 1'b0;
                product_inv_out        <= 1'b0;
            end

            _RESET:
            begin
                multiplicand_inv_out   <= 1'b0;
                multiplicand_wr_out    <= 1'b0;
                multiplicand_shift_out <= 2'b00;
                multiplier_inv_out     <= 1'b0; 
                multiplier_wr_out      <= 1'b0;
                signal_bit_wr_out      <= 1'b0;
                product_wr_out         <= 1'b0;
                multiplicand_reset_out <= 1'b1;
                multiplier_reset_out   <= 1'b1;
                product_reset_out      <= 1'b1;
                signal_bit_reset_out   <= 1'b1;
                product_inv_out        <= 1'b0;
                
                pos = 0;
                signal_bit_read <= 1'b0;
                done_out <= 1'b0; 
                overflow_out <= 1'b0;
            end

            _INVERT:
            begin
                if(!signal_bit_read)
                begin
                    multiplicand_inv_out   <= 1'b0;
                    multiplicand_wr_out    <= 1'b0;
                    multiplier_inv_out     <= 1'b0; 
                    multiplier_wr_out      <= 1'b0;
                    signal_bit_wr_out      <= 1'b1;
                    
                    mult_finished <= 1'b0;
                    signal_bit_read   <= 1'b1;
                end
                else
                begin
                    if(signal_bit_in[1])
                        multiplicand_inv_out   <= 1'b1;
                    else
                        multiplicand_inv_out   <= 1'b0;

                    multiplicand_wr_out    <= 1'b1;

                    if(signal_bit_in[0])
                        multiplier_inv_out   <= 1'b1;
                    else
                        multiplier_inv_out   <= 1'b0;
                        
                    multiplier_wr_out      <= 1'b1;

                    signal_bit_wr_out <= 1'b0;
                    shift <= 0;
                end

                multiplicand_shift_out <= 2'b00;
                product_wr_out         <= 1'b0;
                multiplicand_reset_out <= 1'b0;
                multiplier_reset_out   <= 1'b0;
                product_reset_out      <= 1'b0;
                signal_bit_reset_out   <= 1'b0;
                product_inv_out        <= 1'b0;
            end

            _PRODUCT_INCREMENT:
            begin
                if(pos<WIDTH)
                    begin
                    if(shift)
                    begin
                        pos++;
                        multiplicand_shift_out <= 2'b10;
                        product_wr_out <= 1'b0;
                        shift <= 1'b0;
                    end
                    else
                    begin
                        multiplicand_shift_out <= 2'b00;

                        if(multiplier_in[pos])
                        begin
                            product_wr_out <= 1'b1;
                        end
                        else
                        begin
                            product_wr_out <= 1'b0;
                        end

                        shift <= 1'b1;
                    end
                end

                else
                begin
                    multiplicand_shift_out <= 2'b00;
                    product_wr_out <= 1'b0;
                    product_inv_out <= signal_bit_in[1] ^ signal_bit_in[0]; //XOR
                    overflow_out    <= product_msb_in;
                    done_out        <= 1'b1;
                    mult_finished   <= 1'b1;
                end

                multiplicand_inv_out   <= 1'b0;
                multiplicand_wr_out    <= 1'b0;
                multiplier_inv_out     <= 1'b0; 
                multiplier_wr_out      <= 1'b0;
                signal_bit_wr_out      <= 1'b0;
                
                multiplicand_reset_out <= 1'b0;
                multiplier_reset_out   <= 1'b0;
                product_reset_out      <= 1'b0;
                signal_bit_reset_out   <= 1'b0;    
                
            end
        endcase
    end    
endmodule