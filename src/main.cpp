#include "main.hpp"



extern "C" void kernel_main() {
    const char* message = "Hello, World!";
    char* video_memory = (char*) 0xB8000;

    for (int i = 0; message[i] != '\0'; i++) {
        video_memory[i * 2] = message[i];
        video_memory[i * 2 + 1] = 0x07;
    }

    while (1);
}

