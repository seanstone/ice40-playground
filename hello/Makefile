MEMORY = 8k
PROJECT = hello
TOP = setbit

bin: build/$(PROJECT).bin
pnr: build/$(PROJECT).asc
syn: build/$(PROJECT).json

sim: build/$(PROJECT)_tb.vcd

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

build/%.json: %.v
	mkdir -p build/
	# Synthesis
	yosys -p "synth_ice40 -top $(TOP) -json $@" $^

build/%.asc: build/%.json %.pcf
	# Place & route
	nextpnr-ice40 --hx8k --json $< --pcf $(filter %.pcf,$^) --asc $@

build/%.bin: build/%.asc
	# Generate bitstream
	icepack $< $@

clean:
	rm -rf build/