
`timescale 1ns/1ns

module tb_ALU;

    logic [31:0] i_op_a, i_op_b;
    logic [3:0]  i_alu_op;
    logic [31:0] o_alu_data;

    logic [31:0] expected;

    integer pass_count = 0;
    integer fail_count = 0;
    integer total_count = 0;

    // DUT
    ALU dut (
        .i_op_a(i_op_a),
        .i_op_b(i_op_b),
        .i_alu_op(i_alu_op),
        .o_alu_data(o_alu_data)
    );

    // Function tinh ket qua mong doi
    function automatic logic [31:0] calc_expected(
        input logic [31:0] a,
        input logic [31:0] b,
        input logic [3:0]  op
    );
        begin
            case (op)
                4'b0000: calc_expected = a + b; // ADD
                4'b0001: calc_expected = a - b; // SUB

                4'b0010: // SLT: signed less than
                    calc_expected = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;

                4'b0011: // SLTU: unsigned less than
                    calc_expected = (a < b) ? 32'd1 : 32'd0;

                4'b0100: // SRL
                    calc_expected = a >> b[4:0];

                4'b0101: // SLL
                    calc_expected = a << b[4:0];

                4'b0110: // SRA
                    calc_expected = $signed(a) >>> b[4:0];

                4'b0111: // XOR
                    calc_expected = a ^ b;

                4'b1000: // AND
                    calc_expected = a & b;

                4'b1001: // OR
                    calc_expected = a | b;

                default:
                    calc_expected = 32'hXXXXXXXX;
            endcase
        end
    endfunction

    // Task chay mot test
    task automatic check(
        input logic [3:0]  op,
        input logic [31:0] a,
        input logic [31:0] b
    );
    begin
        i_alu_op = op;
        i_op_a   = a;
        i_op_b   = b;

        expected = calc_expected(a, b, op);

        #10;
        total_count = total_count + 1;

        if (o_alu_data === expected) begin
            pass_count = pass_count + 1;
            $display(
                "PASS | OP=%04b | A=%08h | B=%08h | OUT=%08h | EXP=%08h",
                op, a, b, o_alu_data, expected
            );
        end
        else begin
            fail_count = fail_count + 1;
            $display(
                "FAIL | OP=%04b | A=%08h | B=%08h | OUT=%08h | EXP=%08h",
                op, a, b, o_alu_data, expected
            );
        end
    end
    endtask

    initial begin
$dumpfile("ALU.vcd");
$dumpvars(0,tb_ALU);
        $display("========== START ALU TEST ==========");

        // 1. ADD: 0000
        check(4'b0000, 32'd10,        32'd20);
        check(4'b0000, 32'hFFFFFFFF,  32'd1);

        // 2. SUB: 0001
        check(4'b0001, 32'd20,        32'd10);
        check(4'b0001, 32'd10,        32'd20);

        // 3. SLT: 0010
        check(4'b0010, 32'd10,        32'd20);
        check(4'b0010, 32'hFFFFFFFF,  32'd1);

        // 4. SLTU: 0011
        check(4'b0011, 32'd10,        32'd20);
        check(4'b0011, 32'hFFFFFFFF,  32'd1);

        // 5. SRL: 0100
        check(4'b0100, 32'h80000000,  32'd1);
        check(4'b0100, 32'h00000010,  32'd2);

        // 6. SLL: 0101
        check(4'b0101, 32'h00000001,  32'd4);
        check(4'b0101, 32'h00000003,  32'd2);

        // 7. SRA: 0110
        check(4'b0110, 32'h80000000,  32'd1);
        check(4'b0110, 32'hFFFFFFF0,  32'd2);

        // 8. XOR: 0111
        check(4'b0111, 32'hAAAAAAAA,  32'h55555555);
        check(4'b0111, 32'h12345678,  32'hFFFF0000);

        // 9. AND: 1000
        check(4'b1000, 32'hAAAAAAAA,  32'h55555555);
        check(4'b1000, 32'h12345678,  32'hFFFF0000);

        // 10. OR: 1001
        check(4'b1001, 32'hAAAAAAAA,  32'h55555555);
        check(4'b1001, 32'h12340000,  32'h00005678);

for(int i=0;i<10000 ; i++) begin 
check ($urandom_range(0, 9),$urandom , $urandom );
end
        // Summary
        $display("\n========== TEST SUMMARY ==========");
        $display("TOTAL : %0d", total_count);
        $display("PASS  : %0d", pass_count);
        $display("FAIL  : %0d", fail_count);

        if (fail_count == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;
    end

endmodule
