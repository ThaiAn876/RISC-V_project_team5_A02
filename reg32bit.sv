module reg_32bit (
    input  logic        reg_CK,
    input  logic        i_rstn,
    input  logic [31:0] D_in,
    input  logic        en,
    output logic [31:0] Q_out
);

    logic [31:0] D_mux;

    assign D_mux = en ? D_in : Q_out;

    genvar i;
    generate
        for (i = 0; i < 32; i++) begin : reg32
            D_FF dff_inst (
                .D      (D_mux[i]),
                .CK     (reg_CK),
                .i_rstn (i_rstn),
                .Q      (Q_out[i])
            );
        end
    endgenerate

endmodule