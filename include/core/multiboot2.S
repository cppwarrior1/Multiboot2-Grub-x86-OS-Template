.section .multiboot2
.align 8
.long 0xe85250d6
.long 0
.long header_end - header_start
.long -(0xe85250d6 + 0 + (header_end - header_start))

header_start:
    .long 0
header_end:
