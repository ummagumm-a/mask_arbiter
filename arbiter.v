module arbiter
(
	input MAX10_CLK1_50,
	
	input [1:0] KEY,
	input [9:0] SW,
	output [9:0] LEDR
);
	wire clk = MAX10_CLK1_50;
	wire reset = SW [9];
	
	mask_arbiter ma (
		.clk ( clk ),
		.req ( SW [3:0] ),
		.ptr ( SW [5:4] ),
		.grant ( LEDR [3:0] )
	);
	
	
	
endmodule 
	
	