module D_FF (
    input  logic D,
    input  logic CK,
    input  logic i_rstn,
    output logic Q
);

    always_ff @(posedge CK or negedge i_rstn) begin
        if (!i_rstn)
            Q <= 1'b0;
        else
            Q <= D;
    end

endmodule