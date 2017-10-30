`timescale 1ns/1ps
module main3_tb();

logic clk;
logic rst; 
logic go;
logic ps2_data;
logic ps2_clk;
logic led_r;
logic [7:0] led_g;
logic led_r2;
logic [6:0] HEXD_5;
logic [6:0] HEXD_4;
logic [7:0] LCD_DATA;
logic LCD_RW;
logic LCD_EN;
logic LCD_RS;
logic LCD_ON;

main3 main3_0(.clk(clk),.rst(rst), .go(go),.ps2_data(ps2_data),.ps2_clk(ps2_clk),.led_r(led_r),.led_g(led_g),.led_r2(led_r2),.HEXD_5(HEXD_5),.HEXD_4(HEXD_4),.LCD_DATA(LCD_DATA),.LCD_RW(LCD_RW),.LCD_EN(LCD_EN),.LCD_RS(LCD_RS),.LCD_ON(LCD_ON));


initial begin 
	clk = 0;
	rst = 1;
	go = 0;
	ps2_data = 0;
	ps2_clk = 1;
	#36;
	rst = 0;
	go = 1;
	
	#40000000;
	
	
	#40000;
	ps2_data = 0;
	#10000;
	ps2_clk = 0;		//Start bit
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 1;
	#10000;
	ps2_clk = 0;		//D0
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 0;
	#10000;
	ps2_clk = 0;		//D1
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 1;
	#10000;
	ps2_clk = 0;		//D2
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 1;
	#10000;
	ps2_clk = 0;		//D3
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 1;
	#10000;
	ps2_clk = 0;		//D4
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 0;
	#10000;
	ps2_clk = 0;		//D5
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 0;
	#10000;
	ps2_clk = 0;		//D6
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 0;
	#10000;
	ps2_clk = 0;		//D7
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 1;
	#10000;
	ps2_clk = 0;		//Parity
	#40000;
	ps2_clk = 1;
	#40000;
	ps2_data = 1;
	#10000;
	ps2_clk = 0;		//stop
	#40000;
	ps2_clk = 1;

	
	
	
end


initial begin 
	forever #18 clk = ~clk;
end

endmodule
