module keyboard_sim(
	input go,
	input rst,
	input [7:0] data,
	input key_action,
	input clk,
	output ps2_clk,
	output ps2_data
);

enum logic [2:0] {IDLE, WAIT, HIGH, RST0, LOW, RST1} clk_state, clk_nxt_state;

always_comb begin
	case(clk_state)
		IDLE : clk_nxt_state = HIGH;
	endcase
end

endmodule
