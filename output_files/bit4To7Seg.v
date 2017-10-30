
`define n0 ~7'b0111111
`define n1 ~7'b0000110
`define n2 ~7'b1011011
`define n3 ~7'b1001111
`define n4 ~7'b1100110
`define n5 ~7'b1101101
`define n6 ~7'b1111101
`define n7 ~7'b0000111
`define n8 ~7'b1111111
`define n9 ~7'b1100111
`define A  ~7'b1110111
`define B  ~7'b1111111
`define C  ~7'b0111001
`define D  ~7'b0111111
`define E  ~7'b1111001
`define F  ~7'b1110001

module bit4To7Seg (
	input [7:0] value,
	output reg [6:0] HEX0_D,
	output reg [6:0] HEX1_D
);

always @ * begin
	case (value[3:0])
		0 : {HEX0_D} = {`n0}; 
		1 : {HEX0_D} = {`n1};
		2 : {HEX0_D} = {`n2}; 
		3 : {HEX0_D} = {`n3};
		4 : {HEX0_D} = {`n4}; 
		5 : {HEX0_D} = {`n5};
		6 : {HEX0_D} = {`n6}; 
		7 : {HEX0_D} = {`n7};
		8 : {HEX0_D} = {`n8}; 
		9 : {HEX0_D} = {`n9};
		10 : {HEX0_D} = {`A}; 
		11 : {HEX0_D} = {`B};
		12 : {HEX0_D} = {`C}; 
		13 : {HEX0_D} = {`D};
		14 : {HEX0_D} = {`E}; 
		15 : {HEX0_D} = {`F};
			endcase
end


always @ * begin
	case (value[7:4])
		0 : {HEX1_D} = {`n0}; 
		1 : {HEX1_D} = {`n1};
		2 : {HEX1_D} = {`n2}; 
		3 : {HEX1_D} = {`n3};
		4 : {HEX1_D} = {`n4}; 
		5 : {HEX1_D} = {`n5};
		6 : {HEX1_D} = {`n6}; 
		7 : {HEX1_D} = {`n7};
		8 : {HEX1_D} = {`n8}; 
		9 : {HEX1_D} = {`n9};
		10 : {HEX1_D} = {`A}; 
		11 : {HEX1_D} = {`B};
		12 : {HEX1_D} = {`C}; 
		13 : {HEX1_D} = {`D};
		14 : {HEX1_D} = {`E}; 
		15 : {HEX1_D} = {`F};
			endcase
end

endmodule
