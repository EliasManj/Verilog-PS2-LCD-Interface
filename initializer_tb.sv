`timescale 1ns/1ps
module initializer_tb(
);

logic clk;
logic go;
logic rst;
logic init;
logic en;
logic rs;
logic [7:0] db_out;
logic done;

initializer initializer0(.go(go), .rst(rst), .init(init), .en(en), .rs(rs), .db_out(db_out), .done(done), .clk(clk));

initial begin 
	clk = 0;
	rst = 1;
	go = 0;
	init = 0;
	
	#36;
	rst = 0;
	go = 1;
	init = 1;
	
end

initial begin 
	forever #18 clk = ~clk;
end

endmodule
