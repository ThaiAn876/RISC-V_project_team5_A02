module adder_32 
(input logic [31:0] i_a, i_b, 
input logic i_sub,
output logic [31:0] o_sum,
output logic cout,
output logic c31
);
logic [31:1] c;
logic [31:0] b; 
assign b = i_b^{32{i_sub}};
full_adder fa0 (.a(i_a[0]), .b(b[0]), .cin(i_sub), .cout(c[1]), .s(o_sum[0]));

generate
	genvar i;
	for (i = 1; i < 31; i = i + 1)
	begin :gen_fa
	full_adder fa (.a(i_a[i]), .b(b[i]), .cin(c[i]), .cout(c[i+1]), .o_sum(s[i]));
	end
endgenerate

full_adder fa31 (.a(i_a[31]), .b(b[31]), .cin(c[31]), .cout(cout), .s(o_sum[31]));
assign c31 = c[31];

endmodule 


 module full_adder(a, b, cin, cout, s); 
wire add;
input a, b, cin; 
output cout, s; 
assign add= a^b;
assign s= cin^add;
assign cout = (a & b) | cin & add ;
endmodule 