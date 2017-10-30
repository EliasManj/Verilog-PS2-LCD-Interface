module main2(
	input ps2_data,
	input ps2_clk,
	input clk,
	output led_r,
	output [7:0] led_g,
	output led_r2,
	output logic [6:0] HEXD_5,
   output logic [6:0] HEXD_4
);

logic ps2_code_new;
logic [7:0] ps2_code;

always_comb led_g = ps2_code;
always_comb led_r2 = ps2_code_new;

ps2interface ps2(.ps2_data(ps2_data), .ps2_clk(ps2_clk), .clk(clk), .ps2_code(ps2_code), .ps2_code_new(ps2_code_new), .error(led_r));
bit4To7Seg D7Seg (.value(ps2_code) , .HEX0_D(HEXD_4), .HEX1_D(HEXD_5));


endmodule
