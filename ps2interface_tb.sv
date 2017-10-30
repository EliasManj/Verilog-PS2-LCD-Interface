`timescale 1ns/1ps

module ps2interface_tb();

logic ps2_data;
logic ps2_clk;
logic clk;
logic [7:0] ps2_code;
logic ps2_code_new;

ps2interface cls0(.ps2_data(ps2_data), .ps2_clk(ps2_clk), .clk(clk), .ps2_code(ps2_code), .ps2_code_new(ps2_code_new));

initial begin
	clk = 1;
	ps2_clk = 1;
	ps2_data = 0;
	#180;
	
	ps2_clk = 1;
	#35000;
	
	ps2_clk = 1;
	#35000;
	
	
	//------------------------------
	ps2_data = 0;
	#5004;
	ps2_clk = 0;		//Start bit
	#35000;
	
	ps2_clk = 1;		
	#35000;
	
	ps2_data = 0;
	#5004
	ps2_clk = 0;		//D0
	#35000;
	
		ps2_clk = 1;	
	#35000;
	
	ps2_data = 0;
	#5004
	ps2_clk = 0;		//D1
	#35000;
	
		ps2_clk = 1;	
	#35000;
	
	ps2_data = 1;
	#5004
	ps2_clk = 0;		//D2
	#35000;
	
	
		ps2_clk = 1;	
	#35000;
	
	ps2_data = 0;
	#5004
	ps2_clk = 0;		//D3
	#35000;
	

	ps2_clk = 1;	
	#35000;
	
	ps2_data = 1;
	#5004
	ps2_clk = 0;		//D4
	#35000;
	
		ps2_clk = 1;
	#35000;
	
	ps2_data = 0;
	#5004
	ps2_clk = 0;		//D5
	#35000;
	
		ps2_clk = 1;
	#35000;
	
	ps2_data = 0;
	#5004
	ps2_clk = 0;		//D6
	#35000;
	
		ps2_clk = 1;
	#35000;
	
	ps2_data = 0;
	#5004
	ps2_clk = 0;		//D7
	#35000;
	
		ps2_clk = 1;	
	#35000;
	
	ps2_data = 1;
	#5004;
	ps2_clk = 0;		//Parity bit
	#35000;
	
		ps2_clk = 1;
	#35000;
	
	ps2_data = 1;
	#5004;
	ps2_clk = 0;		//Stop bit
	#35000;
	
	
		ps2_clk = 1;
	#35000;
	
	
	
		
end

initial begin 
	forever #18 clk = ~clk;
end

endmodule
