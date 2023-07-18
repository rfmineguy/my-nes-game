SRC_DIR := src
OUT_DIR := out
INC_DIR := inc
RES_DIR := res

SOURCES = $(wildcard $(SRC_DIR)/*.s)
OBJECTS = $(patsubst $(SRC_DIR)/%.s, $(OUT_DIR)/%.o, $(SOURCES))

.PHONY: always clean build
clean:
	rm -r $(OUT_DIR)

always: clean
	@echo "$(OBJECTS)"
	mkdir -p $(OUT_DIR)

build: always $(OUT_DIR)/main.nes

$(OUT_DIR)/main.nes: $(OBJECTS)
	ld65 $^ -v -o $@ -t nes --dbgfile $(OUT_DIR)/main.dbg -m $(OUT_DIR)/main.map 

$(OBJECTS): $(OUT_DIR)/%.o: $(SRC_DIR)/%.s
	ca65 -I . -I $(RES_DIR) $^ -v -o $@ --debug-info 

#REM assemble assembly files
#ca65 src/main.s -v -o out/main.o --debug-info
#ca65 src/controllers.s -v -o out/controllers.o --debug-info
#ca65 src/variables.s -v -o out/variables.o --debug-info
#ca65 src/vec_irq.s -v -o out/variables.o --debug-info
#ca65 src/vec_nmi.s -v -o out/variables.o --debug-info
#ca65 src/vec_reset.s -v -o out/variables.o --debug-info
#
#REM link object files
#ld65 out/*.o -v -o out/main.nes -t nes --dbgfile out/main.dbg -m out/main.map
#