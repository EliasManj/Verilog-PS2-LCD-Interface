module main3(
	input clk,
	input rst, 
	input go,
	input ps2_data,
	input ps2_clk,
	output led_r,
	output [7:0] led_g,
	output led_r2,
	output logic [6:0] HEXD_7,
   output logic [6:0] HEXD_6,
	output logic [6:0] HEXD_5,
   output logic [6:0] HEXD_4,
	output logic [6:0] HEXD_3,
   output logic [6:0] HEXD_2,
	output [7:0] LCD_DATA,
	output LCD_RW,
	output LCD_EN,
	output LCD_RS,
	output LCD_ON
);


logic ps2_code_new;
logic [7:0] ps2_code;
logic [4:0] pointer;

always_comb led_g = ps2_code;
always_comb led_r2 = ps2_code_new;

ps2interface ps2(.ps2_data(ps2_data), .ps2_clk(ps2_clk), .clk(clk), .ps2_code(ps2_code), .ps2_code_new(ps2_code_new), .error(led_r));
ps2_lcd_interface interface0(.clk(clk),.go(go),.rst(rst),.ps2_code(ps2_code),.ps2_code_new(ps2_code_new),.lcd_char(LCD_DATA),.en(LCD_EN),.rs(LCD_RS),.rw(LCD_RW),.on(LCD_ON),.pointer(pointer));
bit4To7Seg D7Seg0(.value(ps2_code) , .HEX0_D(HEXD_4), .HEX1_D(HEXD_5));
bit4To7Seg D7Seg1(.value(LCD_DATA) , .HEX0_D(HEXD_6), .HEX1_D(HEXD_7));
bit4To7Seg D7Seg2(.value({1'b0,1'b0,1'b0,pointer}) , .HEX0_D(HEXD_2), .HEX1_D(HEXD_3));

endmodule
