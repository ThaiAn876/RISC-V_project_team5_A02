	module syn_mem #(
    parameter integer ADDR_WIDTH = 5,
    parameter logic [31:0] START_ADDR = 32'h1000_0000
)(
    input  logic         i_clk,
    input  logic [31:0]  i_addr,
    input  logic [31:0]  i_wdata,
    input  logic [3:0]   i_bmsk,
    input  logic         i_wren,
	 input  logic 			 i_rden,
    output logic [31:0]  o_rdata
);
	localparam size=1<<(ADDR_WIDTH-2);
	logic addr_gt_start;
   logic addr_eq_start;
   logic addr_lt_end;
   logic addr_valid;
	logic [31:0] rdata;
	logic [31:0] offset;
   logic [31:0] mem [0:size-1];
	logic [31:0] i_wordaddr;
	assign offset = i_addr-START_ADDR;
	assign i_wordaddr= offset[31:2];
	always_ff @(posedge i_clk) begin
		if (i_wren & i_bmsk[3] & addr_valid) mem[i_wordaddr][31:24] <= i_wdata[31:24];
		if (i_wren & i_bmsk[2] & addr_valid) mem[i_wordaddr][23:16] <= i_wdata[23:16];
		if (i_wren & i_bmsk[1] & addr_valid) mem[i_wordaddr][15:8] <= i_wdata[15:8];
		if (i_wren & i_bmsk[0] & addr_valid) mem[i_wordaddr][7:0] <= i_wdata[7:0];
	end
	Mag_Cp cp_start (
        .i_a        (i_addr),
        .i_b        (START_ADDR),
        .i_unsigned (1'b1),
        .o_gt       (addr_gt_start),
		  .o_eq		  (addr_eq_start)
    );

    Mag_Cp cp_end (
        .i_a        (i_addr),
        .i_b        (START_ADDR + (1<<ADDR_WIDTH)),
        .i_unsigned (1'b1),
        .o_lt       (addr_lt_end)
    );
   assign addr_valid    = (addr_gt_start|addr_eq_start) & addr_lt_end;
	assign rdata = addr_valid ? mem[i_wordaddr] : 32'b0;
	always_ff @(posedge i_clk) begin
		if (i_rden) o_rdata <= rdata;
	end
endmodule