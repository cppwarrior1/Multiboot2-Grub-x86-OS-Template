OUTPUT_FORMAT(elf32-i386)
ENTRY(kernel_main)

SECTIONS {
    . = 1M;

    .multiboot2 ALIGN(4K) : {
        *(.multiboot2)
    }

    .text ALIGN(4K) : {
        *(.text)
    }

    .data ALIGN(4K) : {
        *(.data)
    }

    .bss ALIGN(4K) : {
        *(COMMON)
        *(.bss)
    }
}
