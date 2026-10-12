module mux_32to1 (
    input  logic [31:0] data_in [0:31],
    input  logic [4:0]  sel,
    output logic [31:0] data_out
);

    always_comb begin
        case (sel)
            5'd0:  data_out = data_in[0];
            5'd1:  data_out = data_in[1];
            5'd2:  data_out = data_in[2];
            5'd3:  data_out = data_in[3];
            5'd4:  data_out = data_in[4];
            5'd5:  data_out = data_in[5];
            5'd6:  data_out = data_in[6];
            5'd7:  data_out = data_in[7];
            5'd8:  data_out = data_in[8];
            5'd9:  data_out = data_in[9];
            5'd10: data_out = data_in[10];
            5'd11: data_out = data_in[11];
            5'd12: data_out = data_in[12];
            5'd13: data_out = data_in[13];
            5'd14: data_out = data_in[14];
            5'd15: data_out = data_in[15];
            5'd16: data_out = data_in[16];
            5'd17: data_out = data_in[17];
            5'd18: data_out = data_in[18];
            5'd19: data_out = data_in[19];
            5'd20: data_out = data_in[20];
            5'd21: data_out = data_in[21];
            5'd22: data_out = data_in[22];
            5'd23: data_out = data_in[23];
            5'd24: data_out = data_in[24];
            5'd25: data_out = data_in[25];
            5'd26: data_out = data_in[26];
            5'd27: data_out = data_in[27];
            5'd28: data_out = data_in[28];
            5'd29: data_out = data_in[29];
            5'd30: data_out = data_in[30];
            5'd31: data_out = data_in[31];

            default: data_out = 32'b0;
        endcase
    end
endmodule