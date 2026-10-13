module mux(
    input  logic A0,
    input  logic A1,
    input  logic Sel,
    output logic Y
);

    logic nSel;
    logic A0_and_nSel;
    logic A1_and_Sel;

    not (nSel, Sel);
    and (A0_and_nSel, A0, nSel);
    and (A1_and_Sel, A1, Sel);
    or  (Y, A0_and_nSel, A1_and_Sel);

endmodule