module ps2_to_ascii(
	input [7:0] ps2_code,
	input [4:0] pointer,
	output pointer_changed,
	output [4:0] new_pointer,
	output logic [7:0] lcd_dbOut,
	output logic rsOut
);

logic rs;
logic [7:0] lcd_db;

always_comb begin
	case(pointer)
		5'd17		:	{lcd_dbOut,rsOut} = {8'hC0,1'b0};
		5'd32 	:  {lcd_dbOut,rsOut} = {8'h80,1'b0};
		default  :  {lcd_dbOut,rsOut} = {lcd_db,rs};
	endcase
end

always_comb begin
	case(ps2_code)
		8'h5A   : {pointer_changed,new_pointer} = {1'b1,((pointer[4]==1'b1)? 5'd0 : 5'd17)};
		default : {pointer_changed,new_pointer} = {1'b0,pointer};
	endcase
end

always_comb begin
	case (ps2_code)
8'h5A : rs = 0; // --^?  ENTER
8'h1E : rs = 1; // --^@  NUL
8'h1C : rs = 1; // --^A  SOH
8'h32 : rs = 1; // --^B  STX
8'h21 : rs = 1; // --^C  ETX
8'h23 : rs = 1; // --^D  EOT
8'h24 : rs = 1; // --^E  ENQ
8'h2B : rs = 1; // --^F  ACK
8'h34 : rs = 1; // --^G  BEL
8'h33 : rs = 1; // --^H  BS
8'h43 : rs = 1; // --^I  HT
8'h3B : rs = 1; // --^J  LF
8'h42 : rs = 1; // --^K  VT
8'h4B : rs = 1; // --^L  FF
8'h3A : rs = 1; // --^M  CR
8'h31 : rs = 1; // --^N  SO
8'h44 : rs = 1; // --^O  SI
8'h4D : rs = 1; // --^P  DLE
8'h15 : rs = 1; // --^Q  DC1
8'h2D : rs = 1; // --^R  DC2
8'h1B : rs = 1; // --^S  DC3
8'h2C : rs = 1; // --^T  DC4
8'h3C : rs = 1; // --^U  NAK
8'h2A : rs = 1; // --^V  SYN
8'h1D : rs = 1; // --^W  ETB
8'h22 : rs = 1; // --^X  CAN
8'h35 : rs = 1; // --^Y  EM
8'h1A : rs = 1; // --^Z  SUB
8'h54 : rs = 1; // --^[  ESC
8'h5D : rs = 1; // --^\  FS
8'h5B : rs = 1; // --^]  GS
8'h36 : rs = 1; // --^^  RS
8'h4E : rs = 1; // --^_  US
8'h4A : rs = 1; // --^?  DEL
		default : rs = 1;
	endcase
end

always_comb begin
	case(ps2_code)
8'h1C : lcd_db = 8'h61; // --a
8'h32 : lcd_db = 8'h62; // --b
8'h21 : lcd_db = 8'h63; // --c
8'h23 : lcd_db = 8'h64; // --d
8'h24 : lcd_db = 8'h65; // --e
8'h2B : lcd_db = 8'h66; // --f
8'h34 : lcd_db = 8'h67; // --g
8'h33 : lcd_db = 8'h68; // --h
8'h43 : lcd_db = 8'h69; // --i
8'h3B : lcd_db = 8'h6A; // --j
8'h42 : lcd_db = 8'h6B; // --k
8'h4B : lcd_db = 8'h6C; // --l
8'h3A : lcd_db = 8'h6D; // --m
8'h31 : lcd_db = 8'h6E; // --n
8'h44 : lcd_db = 8'h6F; // --o
8'h4D : lcd_db = 8'h70; // --p
8'h15 : lcd_db = 8'h71; // --q
8'h2D : lcd_db = 8'h72; // --r
8'h1B : lcd_db = 8'h73; // --s
8'h2C : lcd_db = 8'h74; // --t
8'h3C : lcd_db = 8'h75; // --u
8'h2A : lcd_db = 8'h76; // --v
8'h1D : lcd_db = 8'h77; // --w
8'h22 : lcd_db = 8'h78; // --x
8'h35 : lcd_db = 8'h79; // --y
8'h1A : lcd_db = 8'h7A; // --z
8'h45 : lcd_db = 8'h30; // --0
8'h16 : lcd_db = 8'h31; // --1
8'h1E : lcd_db = 8'h32; // --2
8'h26 : lcd_db = 8'h33; // --3
8'h25 : lcd_db = 8'h34; // --4
8'h2E : lcd_db = 8'h35; // --5
8'h36 : lcd_db = 8'h36; // --6
8'h3D : lcd_db = 8'h37; // --7
8'h3E : lcd_db = 8'h38; // --8
8'h46 : lcd_db = 8'h39; // --9
8'h5A : lcd_db = 8'hC0; // --ENTER
8'h29 : lcd_db = 8'h20; // --SPACE
8'h1E : lcd_db = 8'h00; // --^@  NUL
8'h1C : lcd_db = 8'h01; // --^A  SOH
8'h32 : lcd_db = 8'h02; // --^B  STX
8'h21 : lcd_db = 8'h03; // --^C  ETX
8'h23 : lcd_db = 8'h04; // --^D  EOT
8'h24 : lcd_db = 8'h05; // --^E  ENQ
8'h2B : lcd_db = 8'h06; // --^F  ACK
8'h34 : lcd_db = 8'h07; // --^G  BEL
8'h33 : lcd_db = 8'h08; // --^H  BS
8'h43 : lcd_db = 8'h09; // --^I  HT
8'h3B : lcd_db = 8'h0A; // --^J  LF
8'h42 : lcd_db = 8'h0B; // --^K  VT
8'h4B : lcd_db = 8'h0C; // --^L  FF
8'h3A : lcd_db = 8'h0D; // --^M  CR
8'h31 : lcd_db = 8'h0E; // --^N  SO
8'h44 : lcd_db = 8'h0F; // --^O  SI
8'h4D : lcd_db = 8'h10; // --^P  DLE
8'h15 : lcd_db = 8'h11; // --^Q  DC1
8'h2D : lcd_db = 8'h12; // --^R  DC2
8'h1B : lcd_db = 8'h13; // --^S  DC3
8'h2C : lcd_db = 8'h14; // --^T  DC4
8'h3C : lcd_db = 8'h15; // --^U  NAK
8'h2A : lcd_db = 8'h16; // --^V  SYN
8'h1D : lcd_db = 8'h17; // --^W  ETB
8'h22 : lcd_db = 8'h18; // --^X  CAN
8'h35 : lcd_db = 8'h19; // --^Y  EM
8'h1A : lcd_db = 8'h1A; // --^Z  SUB
8'h54 : lcd_db = 8'h1B; // --^[  ESC
8'h5D : lcd_db = 8'h1C; // --^\  FS
8'h5B : lcd_db = 8'h1D; // --^]  GS
8'h36 : lcd_db = 8'h1E; // --^^  RS
8'h4E : lcd_db = 8'h1F; // --^_  US
8'h4A : lcd_db = 8'h7F; // --^?  DEL
8'hF0 : lcd_db = 8'hF0; // --^?  DEL
default : lcd_db = 8'h69;
	endcase
end

endmodule
