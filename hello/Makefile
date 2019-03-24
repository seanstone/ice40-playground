MEMORY = 8k
PROJECT = hello

sim: build/$(PROJECT)_tb.vcd

syn: build/$(PROJECT).bin

prog: build/$(PROJECT).bin
	iceprog $<

build/%_tb.vcd: %.v %_tb.v
	mkdir -p build/
	# Compile
	iverilog $*.v $*_tb.v -o build/$*_tb.out
	# Simulate
	build/$*_tb.out
	# Visulaize using gtkwave
	gtkwave build/$*_tb.vcd

build/%.bin: %.v %.pcf
	mkdir -p build/
	# Synthesis
	yosys -p "synth_ice40 -blif build/$*.blif" $*.v
	# Place & route
	arachne-pnr -d $(MEMORY) -p $*.pcf build/$*.blif -o build/$*.txt
	# Generate bitstream
	icepack build/$*.txt build/$*.bin

clean:
	rm -rf build/