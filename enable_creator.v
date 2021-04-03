module enable_creator
(
	input clk,
	input reset,
	
	output enable
);

	reg [31:0] cnt;
	 
	always @ (posedge clk or posedge reset)
		if (reset)
			cnt = 32'b0;
		else
			cnt = cnt + 1;
	 
	assign enable = cnt[22:0] == 23'b0;
	
endmodule 
