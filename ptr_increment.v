module ptr_increment
(
	input [1:0] ptr,
	input permission,
	
	output reg [1:0] incremented_ptr
);

	reg [1:0] res = ptr;
		
	always @ (posedge permission)
		res = res + 1;
	
	incremented_ptr = res;
	
endmodule
	