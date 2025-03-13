SRC_DIR = src
BUILD_DIR = build
INCLUDE_DIR = include
TEMP_DIR = temp
LINKERS_DIR = linkers
GRUB_DIR = grub

MAIN_CPP = src/main.cpp
MULTIBOOT_ASM = include/core/multiboot2.S

MAIN_OBJ = temp/kernel.o
MULTIBOOT_OBJ = temp/multiboot2.o
KERNEL_ELF = temp/kernel.elf

ISO_IMAGE = build/ZyOS.iso

# Create the temp directory
make_temp:
	mkdir -p temp

# Compile the Multiboot2 assembly file
make_multiboot:
	x86_64-elf-gcc -c include/core/multiboot2.S -o temp/multiboot2.o -ffreestanding -m32

# Compile the kernel source file
make_kernel_obj:
	x86_64-elf-g++ -c src/main.cpp -o temp/kernel.o -Iinclude -ffreestanding -m32 -nostdlib

# Link everything into the final kernel ELF
make_elf:
	x86_64-elf-ld -m elf_i386 -T linkers/linker.ld -o temp/kernel.elf temp/multiboot2.o temp/kernel.o -nostdlib -static

# Build the ISO with GRUB
make_iso:
	mkdir -p grub-iso/boot/grub
	cp temp/kernel.elf grub-iso/boot
	cp grub/grub.cfg grub-iso/boot/grub
	grub-mkrescue -o build/ZyOS.iso grub-iso/

# Clean build files
clean:
	rm -rf temp/*
	rm -rf build/*
	rm -rf grub-iso

# Build everything and run in QEMU
all: clean make_temp make_multiboot make_kernel_obj make_elf make_iso run

run:
	qemu-system-i386 -cdrom build/ZyOS.iso
