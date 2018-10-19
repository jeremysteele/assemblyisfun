#!/bin/bash

nasm -f elf32 main.asm -o main.o
ld main.o -m elf_i386 -o assemblyisfun
./assemblyisfun