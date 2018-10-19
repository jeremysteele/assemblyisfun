section .text
   global _start

_start:
    mov ecx, 10
    mov eax, '0'

looper:
    push ecx            ; PUSH  
    mov [buffer], eax

    ; WRITE STDOUT
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 1
    int 80h

    ; INCREMENT VALUE
    mov eax, [buffer]
    inc eax

    pop ecx             ; POP
    loop looper


exit:
    ; WRITE NEWLINE
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    ; Exit 
    mov eax, 1
    mov ebx, 0
    int 80h

section .bss           
    buffer resb 1

section .rodata
newline:    db 0x0a