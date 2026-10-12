module decoder_5to32 (
    input  wire [4:0]  i_addr,
    output wire [31:0] o_decode
);

    // 5 cong NOT
    wire n4, n3, n2, n1, n0;

    not U_NOT4 (n4, i_addr[4]);
    not U_NOT3 (n3, i_addr[3]);
    not U_NOT2 (n2, i_addr[2]);
    not U_NOT1 (n1, i_addr[1]);
    not U_NOT0 (n0, i_addr[0]);

    // Y0 = m0 = 00000
    and U_AND0  (o_decode[0],  n4, n3, n2, n1, n0);

    // Y1 = m1 = 00001
    and U_AND1  (o_decode[1],  n4, n3, n2, n1, i_addr[0]);

    // Y2 = m2 = 00010
    and U_AND2  (o_decode[2],  n4, n3, n2, i_addr[1], n0);

    // Y3 = m3 = 00011
    and U_AND3  (o_decode[3],  n4, n3, n2, i_addr[1], i_addr[0]);

    // Y4 = m4 = 00100
    and U_AND4  (o_decode[4],  n4, n3, i_addr[2], n1, n0);

    // Y5 = m5 = 00101
    and U_AND5  (o_decode[5],  n4, n3, i_addr[2], n1, i_addr[0]);

    // Y6 = m6 = 00110
    and U_AND6  (o_decode[6],  n4, n3, i_addr[2], i_addr[1], n0);

    // Y7 = m7 = 00111
    and U_AND7  (o_decode[7],  n4, n3, i_addr[2], i_addr[1], i_addr[0]);

    // Y8 = m8 = 01000
    and U_AND8  (o_decode[8],  n4, i_addr[3], n2, n1, n0);

    // Y9 = m9 = 01001
    and U_AND9  (o_decode[9],  n4, i_addr[3], n2, n1, i_addr[0]);

    // Y10 = m10 = 01010
    and U_AND10 (o_decode[10], n4, i_addr[3], n2, i_addr[1], n0);

    // Y11 = m11 = 01011
    and U_AND11 (o_decode[11], n4, i_addr[3], n2, i_addr[1], i_addr[0]);

    // Y12 = m12 = 01100
    and U_AND12 (o_decode[12], n4, i_addr[3], i_addr[2], n1, n0);

    // Y13 = m13 = 01101
    and U_AND13 (o_decode[13], n4, i_addr[3], i_addr[2], n1, i_addr[0]);

    // Y14 = m14 = 01110
    and U_AND14 (o_decode[14], n4, i_addr[3], i_addr[2], i_addr[1], n0);

    // Y15 = m15 = 01111
    and U_AND15 (o_decode[15], n4, i_addr[3], i_addr[2], i_addr[1], i_addr[0]);

    // Y16 = m16 = 10000
    and U_AND16 (o_decode[16], i_addr[4], n3, n2, n1, n0);

    // Y17 = m17 = 10001
    and U_AND17 (o_decode[17], i_addr[4], n3, n2, n1, i_addr[0]);

    // Y18 = m18 = 10010
    and U_AND18 (o_decode[18], i_addr[4], n3, n2, i_addr[1], n0);

    // Y19 = m19 = 10011
    and U_AND19 (o_decode[19], i_addr[4], n3, n2, i_addr[1], i_addr[0]);

    // Y20 = m20 = 10100
    and U_AND20 (o_decode[20], i_addr[4], n3, i_addr[2], n1, n0);

    // Y21 = m21 = 10101
    and U_AND21 (o_decode[21], i_addr[4], n3, i_addr[2], n1, i_addr[0]);

    // Y22 = m22 = 10110
    and U_AND22 (o_decode[22], i_addr[4], n3, i_addr[2], i_addr[1], n0);

    // Y23 = m23 = 10111
    and U_AND23 (o_decode[23], i_addr[4], n3, i_addr[2], i_addr[1], i_addr[0]);

    // Y24 = m24 = 11000
    and U_AND24 (o_decode[24], i_addr[4], i_addr[3], n2, n1, n0);

    // Y25 = m25 = 11001
    and U_AND25 (o_decode[25], i_addr[4], i_addr[3], n2, n1, i_addr[0]);

    // Y26 = m26 = 11010
    and U_AND26 (o_decode[26], i_addr[4], i_addr[3], n2, i_addr[1], n0);

    // Y27 = m27 = 11011
    and U_AND27 (o_decode[27], i_addr[4], i_addr[3], n2, i_addr[1], i_addr[0]);

    // Y28 = m28 = 11100
    and U_AND28 (o_decode[28], i_addr[4], i_addr[3], i_addr[2], n1, n0);

    // Y29 = m29 = 11101
    and U_AND29 (o_decode[29], i_addr[4], i_addr[3], i_addr[2], n1, i_addr[0]);

    // Y30 = m30 = 11110
    and U_AND30 (o_decode[30], i_addr[4], i_addr[3], i_addr[2], i_addr[1], n0);

    // Y31 = m31 = 11111
    and U_AND31 (o_decode[31], i_addr[4], i_addr[3], i_addr[2], i_addr[1], i_addr[0]);

endmodule