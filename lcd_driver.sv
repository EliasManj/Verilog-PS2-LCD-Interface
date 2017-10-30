module lcd_driver(
	input clk,
	input rst,
	input go,
	input pointer_changed,
	input [4:0] new_pointer,
	input rs_in,
	input writeW,
	input [7:0] db_in,
	output logic rs,
	output logic rw,
	output logic on,
	output logic en,
	output logic [7:0] db_out,
	output logic [4:0] pointer
);

enum logic [4:0] {IDLE,INIT,WAITCMD,CHECK,WAITCMD2,ENABLER,WAITEN} state, nxt_state;
//initializer
logic enIn;
logic rsIn;
logic [7:0] db_outIn;
logic doneIn;
logic init;
initializer initializer0(.go(go), .rst(rst), .init(init), .en(enIn), .rs(rsIn), .db_out(db_outIn), .done(doneIn), .clk(clk));
always_comb init = (state==INIT);
//enabler
logic enable;
logic rsUs;
logic enUs;
enabler enabler0(.go(go), .rst(rst), .enable(enable), .rs_in(rs_in), .rs(rsUs), .en(enUs), .en_done(en_done), .clk(clk));

always_comb enable = (state==ENABLER);

//check char
logic isF0;
always_comb isF0 = (db_in==8'hF0);

//state
always_comb begin
	case(state)
		IDLE		:	nxt_state =	(go)? INIT : IDLE;
		INIT		:	nxt_state =	(doneIn)? WAITCMD : INIT;
		WAITCMD	:	nxt_state =	(writeW)? CHECK : WAITCMD;
		CHECK		:  nxt_state = (isF0)?  WAITCMD2 : ENABLER;
		WAITCMD2 :  nxt_state = (writeW)? WAITCMD : WAITCMD2;
		ENABLER	:	nxt_state =	WAITEN;
		WAITEN	:	nxt_state = (en_done)? WAITCMD : WAITEN;
	endcase
end

always_ff @(posedge clk) begin
	state <= (rst)? IDLE : nxt_state;
end


//master mux
always_comb begin
	case(state)
		IDLE		:	{en,rs,db_out,rw,on} = {enIn,rsIn,db_outIn,1'b0,1'b0};
		INIT		:	{en,rs,db_out,rw,on} = {enIn,rsIn,db_outIn,1'b0,1'b1};
		WAITCMD	:	{en,rs,db_out,rw,on} = {enUs,rsUs,db_in,1'b0,1'b1};
		CHECK		:	{en,rs,db_out,rw,on} = {enUs,rsUs,db_in,1'b0,1'b1};
		WAITCMD2 : 	{en,rs,db_out,rw,on} = {enUs,rsUs,db_in,1'b0,1'b1};
		ENABLER	:	{en,rs,db_out,rw,on} = {enUs,rsUs,db_in,1'b0,1'b1};
		WAITEN	:	{en,rs,db_out,rw,on} = {enUs,rsUs,db_in,1'b0,1'b1};
	endcase
end

//pointer track
//logic [3:0] pointer;
logic pointer_clr;
logic pointer_inc;

always_comb pointer_clr = (state==IDLE);
always_comb pointer_inc = (state==ENABLER);

always_ff @(posedge clk) begin
	if (pointer_clr) pointer <= 5'b0;
	else if (pointer_changed) pointer <= new_pointer;
	else if (pointer_inc) pointer <= pointer + 5'b1;
end


endmodule

