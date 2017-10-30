`timescale 1ns/1ps
module enabler_tb();

logic go;
logic clk;
logic rst;
logic enable;
logic	rs_in;
logic rs;
logic en;
logic en_done;

enabler enabler0(.go(go), .rst(rst), .enable(enable), .rs_in(rs_in), .rs(rs), .en(en), .en_done(en_done), .clk(clk));

initial begin 
	clk = 0;
	go = 0;
	rst = 1;
	enable = 0;
	rs_in = 1;
	#36;
	
	go = 1;
	rst = 0;
	enable = 1;
	
	#200;
	enable = 0;
	
end

initial begin 
	forever #18 clk = ~clk;
end

endmodule
