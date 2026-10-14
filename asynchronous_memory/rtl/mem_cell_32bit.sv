module memory_cell_32bit (
    input  logic        i_clk,
    input  logic [31:0] i_wdata,
    input  logic [3:0]  i_en,
    output logic [31:0] o_data
);

    memory_cell_8bit u_byte0 (
        .i_clk   (i_clk),
        .i_wdata (i_wdata[7:0]),
        .i_en    (i_en[0]),
        .o_data  (o_data[7:0])
    );

    memory_cell_8bit u_byte1 (
        .i_clk   (i_clk),
        .i_wdata (i_wdata[15:8]),
        .i_en    (i_en[1]),
        .o_data  (o_data[15:8])
    );

    memory_cell_8bit u_byte2 (
        .i_clk   (i_clk),
        .i_wdata (i_wdata[23:16]),
        .i_en    (i_en[2]),
        .o_data  (o_data[23:16])
    );

    memory_cell_8bit u_byte3 (
        .i_clk   (i_clk),
        .i_wdata (i_wdata[31:24]),
        .i_en    (i_en[3]),
        .o_data  (o_data[31:24])
    );

endmodule