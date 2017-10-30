`timescale 1ns/1ps
module ps2_lcd_interface_tb();

logic clk;
logic go;
logic rst;
logic [7:0] ps2_code;
logic ps2_code_new;
logic [7:0] lcd_char;
logic en;
logic rs;

ps2_lcd_interface ps2_lcd_interface0(.clk(clk),.go(go),.rst(rst),.ps2_code(ps2_code),.ps2_code_new(ps2_code_new),.lcd_char(lcd_char),.en(en),.rs(rs));

initial begin 
	clk = 0;
	rst = 1;
	go = 0;
	ps2_code = 8'h00;
	ps2_code_new = 0;
	#36;
	go = 1;
	rst = 0;
	#40000000;
	ps2_code = 8'h1C;
	ps2_code_new = 1;
	
end

initial begin 
	forever #18 clk = ~clk;
end

endmodule
