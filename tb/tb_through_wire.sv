class test;
  rand logic [3:0] test;

endclass


module tb_through_wire();

  parameter clk_freq_hz = 50_000;
  localparam clk_half_period = 1000_000_000/clk_freq_hz/2;
  //Variables
  logic a;
  logic b;

  reg clk = 1'b1;

  always #clk_half_period clk <= !clk;

  through_wire #() 
  dut (
    .a(a),
    .b(b)
  );

  initial begin
    test test;
    test = new();
    if (!(test.randomize())) begin
      $error("Randomization failed");
    end
    $display("test : 0x%h",test.test);

    repeat(2) @(posedge clk);
    //a = 1;
    std::randomize (a);
    repeat(2) @(posedge clk);
    assert(b == a);
    $display("Hello World");
    $finish;
  end
endmodule