module adder_32 
(input logic [31:0] a, b , 
input logic cin,
output logic [31:0] s,
output logic cout,
output logic c31
);
wire [31:1] c;
full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .cout(c[1]), .s(s[0]));

generate
	genvar i;
	for (i = 1; i < 31; i = i + 1)
	begin :gen_fa
	full_adder fa (.a(a[i]), .b(b[i]), .cin(c[i]), .cout(c[i+1]), .s(s[i]));
	end
endgenerate

full_adder fa31 (.a(a[31]), .b(b[31]), .cin(c[31]), .cout(cout), .s(s[31]));
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