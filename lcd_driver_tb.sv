`timescale 1ns/1ps
module lcd_driver_tb();

logic clk;
logic rst;
logic go;
logic rs_in;
logic writeW;
logic [7:0] db_in;
logic rs;
logic en;
logic [7:0] db_out;

lcd_driver lcd_driver0(.clk(clk),.rst(rst),.go(go),.rs_in(rs_in),.writeW(writeW),.db_in(db_in),.en(en),.db_out(db_out));

initial begin 
	clk = 0;
	go = 0;
	rst = 1;
	writeW = 0;
	rs_in = 1;
	db_in = 8'h35;
	#36;
	
	go = 1;
	rst = 0;
	
	#40000000;
	writeW = 1;
	
	#36;
	writeW = 0;
end

initial begin 
	forever #18 clk = ~clk;
end

endmodule
