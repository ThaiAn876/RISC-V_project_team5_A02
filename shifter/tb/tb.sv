
`timescale 1ns/1ns

module tb_shifter;

    logic [31:0] i_data;
    logic [4:0]  i_shamt;
    logic [1:0]  i_mode;
    logic [31:0] o_data;

    logic [31:0] expected;

    integer pass_count  = 0;
    integer fail_count  = 0;
    integer total_count = 0;

    // DUT
    shifter uut (
        .i_data  (i_data),
        .i_shamt (i_shamt),
        .i_mode  (i_mode),
        .o_data  (o_data)
    );

    // Task to test one case
    task automatic test_case(
        input logic [31:0] data,
        input logic [4:0]  shamt,
        input logic [1:0]  mode
    );
    begin
        i_data  = data;
        i_shamt = shamt;
        i_mode  = mode;

        case (mode)
            2'b00: expected = data >> shamt;
            2'b01: expected = data << shamt;
            2'b10: expected = $signed(data) >>> shamt;
            2'b11: expected = 32'b0;
            default: expected = 32'b0;
        endcase

        #10;
        total_count = total_count + 1;

        if (o_data === expected) begin
            pass_count = pass_count + 1;

            $display("PASS | mode=%02b shamt=%05b (%0d)", mode, shamt, shamt);
            $display("     | data     = %032b", data);
            $display("     | output   = %032b", o_data);
            $display("     | expected = %032b", expected);
        end
        else begin
            fail_count = fail_count + 1;

            $display("FAIL | mode=%02b shamt=%05b (%0d)", mode, shamt, shamt);
            $display("     | data     = %032b", data);
            $display("     | output   = %032b", o_data);
            $display("     | expected = %032b", expected);
        end

        $display("---------------------------------------------------------------");
    end
    endtask

    initial begin
	$dumpfile("shift.vcd");

        $dumpvars(0, tb_shifter);

        $display("===============================================================");
        $display("                  SHIFTER TESTBENCH START");
        $display("===============================================================");

        // Mode 00: Logical right shift
        test_case(32'b10000000000000000000000000000001,  0, 2'b00);
        test_case(32'b10000000000000000000000000000001, 16, 2'b00);
        test_case(32'b10000000000000000000000000000001, 31, 2'b00);

        // Mode 01: Logical left shift
        test_case(32'b10000000000000000000000000000001,  0, 2'b01);
        test_case(32'b00000000000000000000000000000001, 16, 2'b01);
        test_case(32'b00000000000000000000000000000001, 31, 2'b01);

        // Mode 10: Arithmetic right shift (negative number)
        test_case(32'b10000000000000000000000000000000,  0, 2'b10);
        test_case(32'b10000000000000000000000000000000, 16, 2'b10);
        test_case(32'b10000000000000000000000000000000, 31, 2'b10);

        // Mode 10: Arithmetic right shift (positive number)
        test_case(32'b01110000000000000000000000000000,  4, 2'b10);
        test_case(32'b01110000000000000000000000000000, 31, 2'b10);

        // Mode 11: Reserved
        test_case(32'b11111111111111111111111111111111,  0, 2'b11);
        test_case(32'b10000000000000000000000000000000, 16, 2'b11);
        test_case(32'b00010010001101000101011001111000, 31, 2'b11);
        
          for(int i = 0; i<10000; i++) begin
            test_case($urandom, $urandom,$urandom);
        end
        $display("");
        $display("===============================================================");
        $display("                       TEST SUMMARY");
        $display("===============================================================");
        $display("Total : %0d", total_count);
        $display("PASS  : %0d", pass_count);
        $display("FAIL  : %0d", fail_count);
        $display("===============================================================");

        if (fail_count == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;
    end

endmodule
