module debouncer_tb();

logic button;
logic clk;
logic result;

ddebouncer db(.clk(clk), .result(result), .button(button));

initial begin
	clk = 0;
	button = 0;
	
	#19;
	button = 1;
	
	#80;
	button = 0;
	
	#400;
	button = 1;
	
		#19;
	button = 0;
		#200;
	button = 0;
		#19;
	button = 1;
		#19;
	button = 0;
	
end

initial begin
	forever #18 clk = ~clk;
end

endmodule
