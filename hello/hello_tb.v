module setbit_tb;

wire LED1;

setbit SB1 (
  .LED1 (LED1)
);

initial begin

    $dumpfile("build/hello_tb.vcd");

	$dumpvars(0, setbit_tb);

    # 10 if (LED1 != 1)
        $display("Error!");
			else
			    $display("Ok!");

	# 10 $finish;
end

endmodule