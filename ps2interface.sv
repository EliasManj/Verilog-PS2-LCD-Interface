module ps2interface(
	input ps2_data,
	input ps2_clk,
	input clk,
	output logic [7:0] ps2_code,
	output logic ps2_code_new,
	output logic error
);

//sincronize
logic ps2_dataR;
logic ps2_clkR;

always_ff @(posedge clk) begin
	ps2_dataR <= ps2_data; 
	ps2_clkR <= ps2_clk;
end

//debounce
//ddebouncer db0(.clk(clk), .button(ps2_dataR), .result(ps2_dataR));
//ddebouncer db1(.clk(clk), .button(ps2_clkR), .result(ps2_clkR));

//shift regidter
logic sr10;
logic sr9;
logic sr8;
logic sr7;
logic sr6;
logic sr5;
logic sr4;
logic sr3;
logic sr2;
logic sr1;
logic sr0;

initial sr10 = 1'b0;
initial sr9 = 1'b0;
initial sr8 = 1'b0;
initial sr7 = 1'b0;
initial sr6 = 1'b0;
initial sr5 = 1'b0;
initial sr4 = 1'b0;
initial sr3 = 1'b0;
initial sr2 = 1'b0;
initial sr1 = 1'b0;
initial sr0 = 1'b0;

always_ff @(negedge ps2_clk) begin
	sr10 <= ps2_dataR;
	sr9 <= sr10;
	sr8 <= sr9;
	sr7 <= sr8;
	sr6 <= sr7;
	sr5 <= sr6;
	sr4 <= sr5;
	sr3 <= sr4;
	sr2 <= sr3;
	sr1 <= sr2;
	sr0 <= sr1;
end 


//counter
logic [15:0] counter;
logic counter_clr; 
logic eq55;

always_comb counter_clr = ~ps2_clkR;
always_comb eq55  = (counter==16'd1389);

initial counter <= 16'd0;

always_ff @(posedge clk) begin
	if ((counter_clr))
		counter <= 16'd0;
	else if (~eq55)
		counter <= counter + 16'd1;
end

//error check
//logic error;
always_comb error = ~(~ sr0 & sr10 & (sr9 ^ sr8 ^
        sr7 ^ sr6 ^ sr5 ^ sr4 ^ sr3 ^ 
        sr2 ^ sr1));

//ps2_code_new
logic andCode;
always_comb andCode = (~error)&(eq55);

logic prev_ps2_code_same;

always_ff @(posedge clk) begin
//if((~(ps2_code=={sr8,sr7,sr6,sr5,sr4,sr3,sr2,sr1}))&(andCode))
	if((~(ps2_code=={sr8,sr7,sr6,sr5,sr4,sr3,sr2,sr1}))&(andCode))
	ps2_code_new <= 1'b1;
	else ps2_code_new <= 1'b0;
end

//ps2 word 
always_ff @(posedge clk) begin
	if (andCode)
		ps2_code <= {sr8,sr7,sr6,sr5,sr4,sr3,sr2,sr1};
end


endmodule
