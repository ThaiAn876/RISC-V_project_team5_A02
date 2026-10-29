module Register_file (
  input  logic        i_clk,
  input  logic        i_rstn,
  input  logic [4:0]  i_rs1_addr,
  input  logic [4:0]  i_rs2_addr,
  input  logic [4:0]  i_rd_addr,
  input  logic [31:0] i_rd_data,
  input  logic        i_rd_wren,
  output logic  [31:0] o_rs1_data,
  output logic  [31:0] o_rs2_data
);

	logic [31:0] register [0:31];
	logic addr_check;
	assign addr_check = (|i_rd_addr)&i_rd_wren;
	always_ff @(posedge i_clk, negedge i_rstn) begin
		if (!i_rstn) begin 
			for (integer k = 1 ; k < 32; k++)
				register[k] <= 32'b0;
		end	
		else if (addr_check) begin
			register[i_rd_addr] <= i_rd_data;
		end
	end
	mux_32to1 mux1 (
		.data_in (register),
		.sel		(i_rs1_addr),
		.data_out (o_rs1_data));
	//assign o_rs1_data=register[i_rs1_addr];
	mux_32to1 mux2 (
		.data_in (register),
		.sel		(i_rs2_addr),
		.data_out (o_rs2_data));
endmodule