module enabler(
	input go,
	input clk,
	input rst,
	input enable,
	input rs_in,
	output logic rs,
	output logic en,
	output logic en_done
);


enum logic [4:0] {IDLE,WAIT,SETRS,WAITAS,RST0,EN_HIGH,RST1,EN_LOW,EN_DONE} state, nxt_state;

//Counters
logic counter_ld;
logic counter_rst;
logic [15:0] counter;

always_comb en = (state==EN_HIGH);
always_comb en_done = (state==EN_DONE);
always_comb counter_ld = (state==EN_HIGH)|(state==EN_LOW)|(state==WAITAS);
always_comb counter_rst = (state==IDLE)|(state==RST0)|(state==RST1)|(state==WAIT);

always_ff @(posedge clk) begin
	if (counter_rst) counter <= 16'd0;
	else if(counter_ld) counter <= counter + 16'd1;
end

always_comb begin
	case(state)
		IDLE : nxt_state = (go)? WAIT : IDLE;
		WAIT : nxt_state = (enable)? SETRS : WAIT;
		SETRS : nxt_state = WAITAS;
		WAITAS : nxt_state = (counter==3)? RST0 : WAITAS;
		RST0 : nxt_state = EN_HIGH;
		EN_HIGH : nxt_state = (counter==27778)? RST1 : EN_HIGH;
		RST1 : nxt_state = EN_LOW;
		EN_LOW : nxt_state =	(counter==27778)? EN_DONE : EN_LOW;
		EN_DONE : nxt_state = WAIT;
	endcase
end

always_ff @(posedge clk) begin
	state <= (rst)? IDLE : nxt_state;
end



always_ff @(posedge clk) begin
	if (rst) rs <= 1'b0;
	else if (state==SETRS) rs <= rs_in;
end

endmodule
