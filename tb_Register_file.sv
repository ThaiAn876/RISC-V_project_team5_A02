module tb_Register_file;

  logic        i_clk;
  logic        i_rstn;
  logic [4:0]  i_rs1_addr;
  logic [4:0]  i_rs2_addr;
  logic [4:0]  i_rd_addr;
  logic [31:0] i_rd_data;
  logic        i_rd_wren;
  wire  [31:0] o_rs1_data;
  wire  [31:0] o_rs2_data;

  integer error_count;
  integer index;

  Register_file dut (
    .i_clk      (i_clk),
    .i_rstn     (i_rstn),
    .i_rs1_addr (i_rs1_addr),
    .i_rs2_addr (i_rs2_addr),
    .i_rd_addr  (i_rd_addr),
    .i_rd_data  (i_rd_data),
    .i_rd_wren  (i_rd_wren),
    .o_rs1_data (o_rs1_data),
    .o_rs2_data (o_rs2_data)
  );

  initial begin
    i_clk = 1'b0;
    forever #5 i_clk = ~i_clk;
  end

  task automatic write_reg(
    input logic [4:0]  address,
    input logic [31:0] data
  );
    begin
      @(negedge i_clk);
      i_rd_addr = address;
      i_rd_data = data;
      i_rd_wren = 1'b1;

      @(negedge i_clk);
      i_rd_wren = 1'b0;
    end
  endtask

  task automatic check_read(
    input logic [4:0]  address1,
    input logic [31:0] expected1,
    input logic [4:0]  address2,
    input logic [31:0] expected2
  );
    begin
      @(negedge i_clk);
      i_rs1_addr = address1;
      i_rs2_addr = address2;
      #1;

      if (o_rs1_data !== expected1) begin
        $display("ERROR: rs1 addr=%0d expected=%h got=%h",
                 address1, expected1, o_rs1_data);
        error_count = error_count + 1;
      end

      if (o_rs2_data !== expected2) begin
        $display("ERROR: rs2 addr=%0d expected=%h got=%h",
                 address2, expected2, o_rs2_data);
        error_count = error_count + 1;
      end
    end
  endtask

  initial begin
    i_rstn = 1'b0;
    i_rs1_addr = 5'd0;
    i_rs2_addr = 5'd0;
    i_rd_addr = 5'd0;
    i_rd_data = 32'b0;
    i_rd_wren = 1'b0;
    error_count = 0;

    // Giữ reset qua hai cạnh clock.
    repeat (2) @(negedge i_clk);
    i_rstn = 1'b1;

    // Sau reset, tất cả thanh ghi đọc về 0.
    for (index = 0; index < 32; index = index + 1) begin
      check_read(index, 32'b0, 31 - index, 32'b0);
    end

    // Ghi và đọc đồng thời qua hai cổng.
    write_reg(5'd1,  32'h1234_5678);
    write_reg(5'd5,  32'hA5A5_5A5A);
    write_reg(5'd31, 32'hDEAD_BEEF);

    check_read(5'd1,  32'h1234_5678,
               5'd31, 32'hDEAD_BEEF);
    check_read(5'd5,  32'hA5A5_5A5A,
               5'd1,  32'h1234_5678);

    // Ghi vào R0 phải bị bỏ qua.
    write_reg(5'd0, 32'hFFFF_FFFF);
    check_read(5'd0, 32'b0, 5'd0, 32'b0);

    // Khi i_rd_wren = 0, R5 phải giữ nguyên dữ liệu.
    @(negedge i_clk);
    i_rd_addr = 5'd5;
    i_rd_data = 32'hFFFF_FFFF;
    i_rd_wren = 1'b0;
    @(negedge i_clk);

    check_read(5'd5, 32'hA5A5_5A5A,
               5'd0, 32'b0);

    // Ghi đè R1.
    write_reg(5'd1, 32'hCAFE_1234);
    check_read(5'd1, 32'hCAFE_1234,
               5'd5, 32'hA5A5_5A5A);

    // Reset lần nữa, kiểm tra dữ liệu đã được xóa.
    i_rstn = 1'b0;
    repeat (2) @(negedge i_clk);
    i_rstn = 1'b1;

    check_read(5'd1, 32'b0,
               5'd31, 32'b0);

    if (error_count == 0) begin
      $display("PASS: all register file checks passed.");
    end else begin
      $display("FAIL: %0d check(s) failed.", error_count);
    end

    $stop;
  end

endmodule