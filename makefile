SRC_DIR	   = src
TOP        = spi_screen
TB         = tb_$(TOP)
VCD        = sim/$(TOP).vcd
VERILOGS   = $(SRC_DIR)/$(TOP).v $(SRC_DIR)/$(TB).v

sim: $(VCD)
$(VCD): $(VERILOGS)
	@mkdir -p sim
	iverilog -o sim/$(TOP) $^
	vvp sim/$(TOP)
	gtkwave $@ &

clean:
	rm -rf sim/

.PHONY: sim clean
