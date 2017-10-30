module initializer(
	input go,
	input rst,
	input init,
	input clk,
	output logic en,
	output logic rs,
	output logic [7:0] db_out,
	output logic done
);

enum logic [5:0] {IDLE,WAIT15MS,FS0,WAITD0,WAIT4MS,FS1,WAITD1,WAIT100US,FS2,WAITD2,DISPLAYOFF,WAITD3,DISPCLR,WAITD4,DISPON,WAITD5,WRMODE,WAITD6,DONE} state, nxt_state;
//enabler
logic en_done;
logic enable;
enabler enabler0(.go(go), .rst(rst), .enable(enable), .rs_in(1'b0), .rs(rs), .en(en), .en_done(en_done), .clk(clk));
//counter
logic counter_ld;
logic counter_rst;
logic [31:0] counter;
//state logic
always_comb begin
	case(state)
		IDLE 			: nxt_state =	(go)? WAIT15MS : IDLE;	
		WAIT15MS 	: nxt_state =	(counter==416677)? FS0 : WAIT15MS;
		FS0			: nxt_state =	 WAITD0;
		WAITD0		: nxt_state =	(en_done)? WAIT4MS : WAITD0;
		WAIT4MS		: nxt_state =	(counter==113889)? FS1 : WAIT4MS;
		FS1			: nxt_state =	WAITD1;
		WAITD1		: nxt_state =	(en_done)? WAIT100US : WAITD1;
		WAIT100US	: nxt_state =	(counter==2787)? FS2 : WAIT100US;
		FS2			: nxt_state =	WAITD2;
		WAITD2   	: nxt_state =  (en_done)? DISPLAYOFF : WAITD2;
		DISPLAYOFF	: nxt_state =	WAITD3;
		WAITD3		: nxt_state =	(en_done)? DISPCLR : WAITD3;
		DISPCLR		: nxt_state =	WAITD4;
		WAITD4		: nxt_state =	(en_done)? DISPON : WAITD4;
		DISPON		: nxt_state =	WAITD5;
		WAITD5		: nxt_state =	(en_done)? WRMODE : WAITD5;
		WRMODE		: nxt_state =	WAITD6;
		WAITD6 		: nxt_state =	(en_done)? DONE : WAITD6;
		DONE			: nxt_state =	DONE;
	endcase
end

always_ff @(posedge clk) begin
	state <= (rst)? IDLE : nxt_state;
end

always_comb done = (state==DONE);
//counter logic
always_comb counter_ld = (state==WAIT15MS)|(state==WAIT4MS)|(state==WAIT100US);
always_comb counter_rst = ~((state==WAIT15MS)|(state==WAIT4MS)|(state==WAIT100US));

always_ff @(posedge clk) begin
	if (counter_rst) counter <= 32'd0;
	else if(counter_ld) counter <= counter + 32'd1;
end
//enable logic
always_comb enable = (state==FS0)|(state==FS1)|(state==FS2)|(state==DISPLAYOFF)|(state==DISPCLR)|(state==DISPON)|(state==WRMODE);
//db_out
always_comb begin
	case(state)
		IDLE 		: db_out =	8'h38;	
		WAIT15MS 	: db_out =	8'h38;
		FS0			: db_out =	8'h38;
		WAITD0		: db_out =	8'h38;
		WAIT4MS		: db_out =	8'h38;
		FS1			: db_out =	8'h38;
		WAITD1		: db_out =	8'h38;
		WAIT100US	: db_out =	8'h38;
		FS2			: db_out =	8'h38;
		WAITD2   	: db_out =  8'h38;
		DISPLAYOFF	: db_out =	8'h08;
		WAITD3		: db_out =	8'h08;
		DISPCLR		: db_out =	8'h01;
		WAITD4		: db_out =	8'h01;
		DISPON		: db_out =	8'h0F;
		WAITD5		: db_out =	8'h0F;
		WRMODE		: db_out =	8'h06;
		WAITD6 		: db_out =	8'h06;
		DONE		: db_out =	 8'h06;
	endcase
end
endmodule
