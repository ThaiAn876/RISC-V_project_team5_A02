module memory_cell_8bit (
    input  logic       i_clk,
    input  logic [7:0] i_wdata,
    input  logic       i_en,
    output logic [7:0] o_data
);

    logic [7:0] D_mux;

    // MUX phan hoi: ghi du lieu moi hoac giu gia tri cu
    assign D_mux = i_en ? i_wdata : o_data;

    // Tao 8 D_FF, moi D_FF luu 1 bit
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_dff
            D_FF u_dff (
                .D      (D_mux[i]),
                .CK     (i_clk),
                .i_rstn (1'b1),
                .Q      (o_data[i])
            );
        end
    endgenerate

endmodule