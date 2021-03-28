module mask_arbiter
  (
    input clk,
	 input reset,
    input [3:0] req,
	 input [1:0] ptr,
	
	 output [3:0] grant
  );
	 reg [3:0] mask;
  	 wire [3:0] mask_grant;
	 wire [3:0] unmask_grant;
    reg [3:0] masked_req;
    reg no_mask;
	 reg [3:0] result;
	
	always @ (posedge clk) begin
		casez (ptr)
			2'b00 : mask <= 4'b1111;
			2'b01 : mask <= 4'b1110;
			2'b10 : mask <= 4'b1100;
			2'b11 : mask <= 4'b1000;
		endcase
	end

  	priority_arbiter pa_for_masked (
		.req ( masked_req ),
      	.clk ( clk ),
    	.grant ( mask_grant )
	);
	
	priority_arbiter pa_for_unmasked (
		.req ( req ),
      	.clk ( clk ),
		.grant ( unmask_grant )
	);
  
  always @ (posedge clk or posedge reset) begin
		masked_req <= mask & req;
		no_mask <= masked_req == 4'h0;
		result <= mask_grant | ( no_mask & unmask_grant );
  end
  
  assign grant = result;
  
endmodule 