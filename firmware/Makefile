VPATH += $(CURDIR)/../picorv32/

bin: build/firmware.bin

prog: build/firmware.bin
	iceprog -o 1M $<

build/hx8kdemo_sections.lds: picosoc/sections.lds
	mkdir -p $(@D)
	riscv32-unknown-elf-cpp -P -DHX8KDEMO -o $@ $<

build/%.elf: build/hx8kdemo_sections.lds picosoc/start.s *.c
	riscv32-unknown-elf-gcc -DHX8KDEMO -march=rv32imc -Wl,-Bstatic,-T,$(word 1,$^),--strip-debug -ffreestanding -nostdlib -o $@ $(word 2,$^) $(filter %.c,$^)

build/%.hex: build/%.elf
	riscv32-unknown-elf-objcopy -O verilog $< $@

build/%.bin: build/%.elf
	riscv32-unknown-elf-objcopy -O binary $< $@

clean:
	rm -rf build/