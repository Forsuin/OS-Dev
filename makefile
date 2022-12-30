all: run

boot.bin: src/boot.asm
	nasm $< -f bin -o $@

os-image.bin: boot.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-x86_64 -fda $<

clean:
	rm *.bin *.o *.dis