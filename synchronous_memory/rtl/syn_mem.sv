	module syn_mem #(
    parameter integer ADDR_WIDTH = 3,
    parameter logic [31:0] START_ADDR = 32'h1000_0000
)(
    input  logic         i_clk,
    input  logic [31:0]  i_addr,
    input  logic [31:0]  i_wdata,
    input  logic [3:0]   i_bmsk,
	 input  logic 			 i_rden,
    input  logic         i_wren,
    output logic [31:0]  o_rdata
);

    localparam integer CELL_COUNT = 1 << (ADDR_WIDTH - 2); // so o nho 32 bit
    logic [31:0] cell_data [0:CELL_COUNT-1]; // output cua o nho 32bit
    logic [CELL_COUNT-1:0] word_sel;
	 logic [31:0] read_data;
	 logic [31:0] offset;
	 logic [29:0] waddr;
	 logic valid_addr;
    genvar i;
    generate
        for (i = 0; i < CELL_COUNT; i = i + 1) begin : GEN_WORD

            localparam logic [31:0] WORD_ADDR =
                START_ADDR + (i * 4);

            logic [3:0] cell_en;

            assign word_sel[i] =
                ~|(i_addr[31:2] ^ WORD_ADDR[31:2]);
            // Chi cho phep ghi word duoc chon
            assign cell_en =
                {4{word_sel[i] & i_wren}} & i_bmsk;

            memory_cell_32bit u_memory_cell (
                .i_clk   (i_clk),
                .i_wdata (i_wdata),
                .i_en    (cell_en),
                .o_data  (cell_data[i])
            );
        end
    endgenerate
	assign offset=i_addr[31:0]-START_ADDR;
	assign waddr=offset[31:2];
	assign valid_addr=|word_sel;
	assign read_data=(valid_addr)? cell_data[waddr] : 32'b0;
   always_ff @(posedge i_clk) begin
      if (i_rden)
         o_rdata <= read_data;
   end

endmodule