module arbiter
(
	input MAX10_CLK1_50,

	input [9:0] SW,
	output [3:0] LEDR
);

	mask_arbiter ma (
		.clk ( MAX10_CLK1_50 ),
		.reset ( SW [7] ),
		.req ( SW [3:0] ),
		.grant ( LEDR [3:0] )
	);
	
endmodule 