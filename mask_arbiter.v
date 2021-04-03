module mask_arbiter
(
  input clk,
  input reset,
  input [3:0] req,

  output [3:0] grant,
);

  wire enable;
  
  enable_creator ec (
    .clk ( clk ),
    .reset ( reset ),
    .enable ( enable )
  );
  
  reg [3:0] mask;
  reg [3:0] my_req;
  always @ (req)
    my_req <= req;
  
  wire [3:0] mask_grant;
  wire [3:0] unmask_grant;
  wire no_mask = (masked_req == 4'h0);
  wire [3:0] masked_req = (mask & my_req);
  
  reg [3:0] result;
  
  // pointer
  reg [1:0] ptr = 2'b10;
  
  // increment pointer on the change of grant
//   always @ (result)
//     ptr <= ptr + 1;

  // move pointer to the next request
  reg [3:0] req_shifted;
  reg [7:0] req_shifted_double;
  
  always @ (grant) begin
    my_req = my_req & ~ grant;
    req_shifted_double = { my_req[3:0], my_req[3:0] } >> ptr;
    req_shifted = req_shifted_double[3:0];
    
    casez (req_shifted[3:0])
		4'b???1 : ptr = ptr;
		4'b??10 : ptr = ptr + 2'b01;
		4'b?100 : ptr = ptr + 2'b10;
		4'b1000 : ptr = ptr + 2'b11;
      4'b0000 : ptr = ptr;
	endcase
  end
  
  // make a mask depending on the value of pointer
  always @ (ptr) begin
	casez (ptr)
	  2'b00 : mask <= 4'b1111;
	  2'b01 : mask <= 4'b1110;
	  2'b10 : mask <= 4'b1100;
	  2'b11 : mask <= 4'b1000;
	endcase
  end

  priority_arbiter pa_for_masked (
    .req ( masked_req ),
    .grant ( mask_grant )
  );

  priority_arbiter pa_for_unmasked (
    .req ( my_req ),
    .grant ( unmask_grant )
  );
  
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      ptr <= 2'b0;
    end else begin
	  result <= mask_grant | ( no_mask & unmask_grant );
    end
  end
  
  assign grant = result;  
endmodule  
