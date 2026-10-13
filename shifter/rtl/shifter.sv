module shifter(
    input logic [31:0] i_data,
    input logic [4:0] i_shamt,
    input logic [1:0] i_mode,
    output logic [31:0] o_data
);

//left shift
    logic [31:0] A_S0;
    logic Ari, left, r_sig;
    assign Ari   = i_data[31] & i_mode[1];
    assign left  = i_mode[0];
    assign r_sig = i_mode[1] & i_mode[0];


    genvar i;
    generate 
        for (i=0; i<32; i++) begin :gen
            mux m(.A0(i_data[i]), .A1(i_data[31-i]), .Sel(left), .Y(A_S0[i]));
        end
    endgenerate

//>>1
    logic [31:0] A_S1;
    
    mux m0(.A0(A_S0[31]), .A1(Ari), .Sel(i_shamt[0]), .Y(A_S1[31]));
    

    generate 
        for (i=0 ; i<31; i++) begin :gen1
            mux m(.A0(A_S0[i]), .A1(A_S0[i+1]), .Sel(i_shamt[0]), .Y(A_S1[i]));

        end
    endgenerate

//>>2
    logic [31:0] A_S2;

    mux m1(.A0(A_S1[31]), .A1(Ari), .Sel(i_shamt[1]), .Y(A_S2[31]));
    mux m2(.A0(A_S1[30]), .A1(Ari), .Sel(i_shamt[1]), .Y(A_S2[30]));
    
    generate 
        for (i=0; i<30; i++) begin :gen2
            mux m(.A0(A_S1[i]), .A1(A_S1[i+2]), .Sel(i_shamt[1]), .Y(A_S2[i]));
        end

    endgenerate

//>>4
    logic [31:0] A_S3;

   
    generate 
        for (i=28; i<32; i++) begin :gen3_0
            mux m(.A0(A_S2[i]), .A1(Ari), .Sel(i_shamt[2]), .Y(A_S3[i]));
        end
    endgenerate

    

    generate 
        for (i=0; i<28; i++) begin :gen3
            mux m(.A0(A_S2[i]), .A1(A_S2[i+4]), .Sel(i_shamt[2]), .Y(A_S3[i]));
        end
    endgenerate

//>>8
    logic [31:0] A_S4;

    
    generate 
        for (i=24; i<32; i++) begin :gen4_0
            mux m(.A0(A_S3[i]), .A1(Ari), .Sel(i_shamt[3]), .Y(A_S4[i]));
        end
    endgenerate

     
    generate 
        for (i=0; i<24; i++) begin :gen4
            mux m(.A0(A_S3[i]), .A1(A_S3[i+8]), .Sel(i_shamt[3]), .Y(A_S4[i]));
        end
    endgenerate

//>>16 
    logic [31:0] A_S5;

  
    generate 
        for (i=16; i<32; i++) begin :gen5_0
            mux m(.A0(A_S4[i]), .A1(Ari), .Sel(i_shamt[4]), .Y(A_S5[i]));
        end 
    endgenerate

   
    generate 
        for (i=0; i<16; i++) begin :gen5
            mux m(.A0(A_S4[i]), .A1(A_S4[i+16]), .Sel(i_shamt[4]), .Y(A_S5[i]));
        end
    endgenerate

//left shift
    logic [31:0] A_S6;
    generate 
        for (i=0; i<32; i++) begin :gen6
            mux m(.A0(A_S5[i]), .A1(A_S5[31-i]), .Sel(left), .Y(A_S6[i]));
        end
    endgenerate

//reserved
    generate 
        for(i=0; i<32; i++) begin :gen7
            mux m(.A0(A_S6[i]), .A1(1'b0), .Sel(r_sig), .Y(o_data[i]));

        end
    endgenerate
endmodule