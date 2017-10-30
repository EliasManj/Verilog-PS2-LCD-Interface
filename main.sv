module main(
  input clk,
  input ps2_data,
  input ps2_clk,
  output logic [7:0] led_g,
  output logic [6:0] HEXD_5,
  output logic [6:0] HEXD_4
);

logic [7:0] key_data;

keyboard keyboard0 (.clock(clk), .ps2_data (ps2_data), .ps2_clk (ps2_clk), .led_g(key_data));
bit4To7Seg D7Seg (.value(key_data) , .HEX0_D(HEXD_4), .HEX1_D(HEXD_5));

always_comb led_g = key_data;

endmodule
