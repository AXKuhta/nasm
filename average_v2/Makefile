SOURCE = $(wildcard *.asm)
OBJS = $(SOURCE:asm=o)

all: result.elf
	@echo "Done"

result.elf: $(OBJS)
	@echo " [LD] result.elf"
	@gcc -g -fno-pie -no-pie $^ -o result.elf

# All .asm files
%.o: %.asm
	@echo " [NASM]" $<
	@nasm -g -felf64 -o $@ $<

debug: result.elf
	@gdb -tui result.elf -ex "layout regs"

clean:
	rm -f *.o *.elf
