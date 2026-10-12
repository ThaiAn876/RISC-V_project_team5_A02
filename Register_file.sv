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

	// Mang chua dau ra cua 32 thanh ghi
   logic [31:0] reg_q [0:31];
	// Decoder va write enable cua tung thanh ghi
   logic [31:0] wr_decode;
   logic [31:0] reg_en;

   // 5-to-32 decoder
   decoder_5to32 u_decoder (
      .i_addr   (i_rd_addr),
      .o_decode (wr_decode)
   );

	// AND write enable voi tung ngo ra decoder
   assign reg_en = wr_decode & {32{i_rd_wren}};
   // Tao register bank
   genvar i;
   generate
      for (i = 0; i < 32; i++) begin : gen_regs

         if (i == 0) begin : zero_reg

            // R0 luon bang 0
            assign reg_q[i] = 32'b0;

         end else begin : normal_reg

               reg_32bit u_reg (
                  .reg_CK (i_clk),
                  .i_rstn (i_rstn),
                  .D_in   (i_rd_data),
                  .en     (reg_en[i]),
                  .Q_out  (reg_q[i])
               );

            end
      end
   endgenerate
	// Mux chon thanh ghi rs
	mux_32to1 u_mux_rs1 (
		.data_in  (reg_q),
		.sel      (i_rs1_addr),
		.data_out (o_rs1_data)
);

	mux_32to1 u_mux_rs2 (
		.data_in  (reg_q),
		.sel      (i_rs2_addr),
		.data_out (o_rs2_data)
);
endmodule