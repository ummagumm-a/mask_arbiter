module arbiter
(
	input MAX10_CLK1_50,

	input [9:0] SW,
	output [9:0] LEDR
);

	mask_arbiter ma (
		.clk ( MAX10_CLK1_50 ),
		.req ( SW [3:0] ),
		.ptr ( SW [5:4] ),
		.grant ( LEDR [3:0] )
	);
	
endmodule 