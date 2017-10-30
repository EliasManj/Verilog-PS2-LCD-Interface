module ps2_lcd_interface(
	input clk,
	input go,
	input rst,
	input [7:0] ps2_code,
	input ps2_code_new,
	output [7:0] lcd_char,
	output en,
	output rs,
	output rw,
	output on,
	output [4:0] pointer
);

logic rsT;
logic [7:0] lcd_db;
logic pointer_changed;
logic [4:0] new_pointer;

ps2_to_ascii ps2ascii(.ps2_code(ps2_code), .lcd_dbOut(lcd_db), .rsOut(rsT), .pointer(pointer), .pointer_changed(pointer_changed), .new_pointer(new_pointer));
lcd_driver lcd_driver0(.clk(clk), .rst(rst), .go(go), .rs_in(rsT), .db_in(lcd_db), .rs(rs), .en(en), .db_out(lcd_char), .writeW(ps2_code_new), .rw(rw), .on(on), .pointer(pointer), .pointer_changed(pointer_changed), .new_pointer(new_pointer));

endmodule
