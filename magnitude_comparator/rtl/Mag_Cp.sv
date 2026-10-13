module Mag_Cp (
    input logic [31:0] i_a, i_b ,
    input logic unsign,
    output logic o_eq, o_gt, o_lt
 );
 logic [31:0] e,p;
 logic a_31, b_31;
 assign e = i_a ^ i_b ; 
  assign a_31 = i_a[31] ^ (~unsign);
  assign b_31 = i_b[31] ^ (~unsign);
 assign o_eq = ~(|e); 

  assign p[31] = ~e[31];
genvar i;
generate
    for (i = 30; i >= 0; i = i - 1) begin
      assign p[i] = ~e[i] & p[i+1];
    end
endgenerate 
assign o_lt =((~a_31 & b_31 ) |
( ~i_a[30] & i_b[30] & p[31] ) |
( ~i_a[29] & i_b[29] & p[30] ) |
( ~i_a[28] & i_b[28] & p[29] ) |
( ~i_a[27] & i_b[27] & p[28] ) | 
( ~i_a[26] & i_b[26] & p[27] ) | 
( ~i_a[25] & i_b[25] & p[26] ) | 
( ~i_a[24] & i_b[24] & p[25] ) | 
( ~i_a[23] & i_b[23] & p[24] ) | 
( ~i_a[22] & i_b[22] & p[23] ) | 
( ~i_a[21] & i_b[21] & p[22] ) | 
( ~i_a[20] & i_b[20] & p[21] ) | 
( ~i_a[19] & i_b[19] & p[20] ) | 
( ~i_a[18] & i_b[18] & p[19] ) | 
( ~i_a[17] & i_b[17] & p[18] ) | 
( ~i_a[16] & i_b[16] &p [17] ) | 
(~i_a [15] & i_b[15] &p [16] ) | 
(~i_a [14] & i_b[14] &p [15] ) | 
(~i_a [13]& i_b [13]&p [14])| 
(~i_a [12]& i_b [12]&p [13])| 
(~i_a [11]& i_b [11]&p [12])| 
(~i_a [10]& i_b [10]&p [11])| 
(~i_a [9]& i_b [9]&p [10])| 
(~i_a [8]& i_b [8]&p [9])| 
(~i_a [7]& i_b [7]&p [8])| 
(~i_a [6]& i_b [6]&p [7])| 
(~i_a [5]& i_b [5]&p [6])| 
(~i_a [4]& i_b [4]&p [5])| 
(~i_a [3]& i_b [3]&p [4])| 
(~i_a [2]& i_b [2]&p [3])| 
(~i_a [1]& i_b [1]&p [2])| 
(~i_a [0]& i_b [0]&p [1])); 

 assign o_gt = ~o_lt & ~o_eq;
endmodule