SRC_DIR	   = src
TOP        = spi_screen
TB         = tb_$(TOP)
VCD        = sim/$(TOP).vcd
VERILOGS   = $(SRC_DIR)/$(TOP).v $(SRC_DIR)/$(TB).v

sim: $(VCD)
$(VCD): $(VERILOGS)
	@mkdir -p sim
	iverilog -o sim/$(TOP).tmp $^
	vvp sim/$(TOP).tmp
	gtkwave $@ &

clean:
	rm -rf sim/*.vcd
	rm -rf sim/*.tmp
	rm -rf sim/*.gtkw

.PHONY: sim clean
