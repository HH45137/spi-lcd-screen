`timescale 1ns/1ps
module tb_spi_screen ();

/* ----------------  连到 DUT 的信号  ---------------- */
reg  clk;
reg  resetn;
wire ser_tx, ser_rx;
wire lcd_resetn, lcd_clk, lcd_cs, lcd_rs, lcd_data;

/* ----------------  实例化被测模块  ---------------- */
spi_screen dut (
    .clk        (clk),
    .resetn     (resetn),
    .ser_tx     (ser_tx),
    .ser_rx     (ser_rx),
    .lcd_resetn (lcd_resetn),
    .lcd_clk    (lcd_clk),
    .lcd_cs     (lcd_cs),
    .lcd_rs     (lcd_rs),
    .lcd_data   (lcd_data)
);

/* ----------------  时钟 27 MHz  ---------------- */
parameter CLK_PER = 37.0;          // 1/27M ≈ 37 ns
always #(CLK_PER/2) clk = ~clk;

/* ----------------  激励  ---------------- */
initial begin
    clk    = 0;
    resetn = 0;
    #200 resetn = 1;               // 200 ns 后释放复位
    #15_000_000 $finish;           // 跑 15 ms 足够看完整初始化 + 部分像素
end

/* ----------------  自动 dump 波形  ---------------- */
initial begin
    $dumpfile("sim/spi_screen.vcd");
    $dumpvars(0, tb_spi_screen);
end

endmodule