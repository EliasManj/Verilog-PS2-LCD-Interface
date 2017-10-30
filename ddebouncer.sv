module ddebouncer(
	input button,
	input clk,
	output logic result
);

logic ff1_out;
logic ff2_out;
logic ff3_out;
logic [3:0] counter;
logic cout;
logic sclr;

always_comb sclr = ff1_out^ff2_out;
always_comb cout = counter[3];
always_comb result = ff3_out;

always_ff @(posedge clk) begin
	ff1_out <= button;
	ff2_out <= ff1_out;
	if(cout)
		ff3_out <= ff2_out;
end

always_ff @(posedge clk) begin
	if (sclr) 
		counter = 4'd0;
	else if (~cout)
		counter = counter + 4'd1;
end

endmodule
