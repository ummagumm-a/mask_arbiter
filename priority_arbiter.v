module priority_arbiter
(
	input [3:0] req,
  	input clk,
	
	output reg [3:0] grant
);
  always @ (posedge clk) begin
	// this coding style is faster for the case with 4 requesters
	casez (req[3:0])
		4'b???1 : grant <= 4'b0001;
		4'b??10 : grant <= 4'b0010;
		4'b?100 : grant <= 4'b0100;
		4'b1000 : grant <= 4'b1000;
	endcase
  end
	
endmodule 