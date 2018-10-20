section .text
   global _start

_start:
    mov ecx, 1234567890
    mov ebx, buffer
    call itoa

    mov ecx, buffer
    call print_rev

    call exit

; Convert integer (ecx) to its ascii  representation (ebx)
itoa:
    ; Divde by 10, save quotient and remainder
    mov edx, 0
    mov eax, ecx
    mov ecx, 10
    div ecx
    push eax            ; PUSH Quotient

    ; Set ascii value in buffer
    add edx, '0'
    mov [ebx], edx

    ; Increment array
    add ebx, 1

    pop ecx             ; POP Quotient
    cmp ecx, 0
    jnz itoa

    ret

; Get null-terminated string (ecx) length, return (eax)
strlen:
    mov eax, 0

    strlen_loop:
    inc eax
    mov ebx, [ecx]
    inc ecx
    cmp ebx, 0
    jnz strlen_loop

    dec eax
    ret

; Print null-terminated string (ecx) in reverse
print_rev:
    push ecx
    call strlen
    pop ecx

    cmp eax, 0
    jz print_rev_ret

    print_rev_loop:
    dec eax

    push ecx            ; PUSH Input
    add ecx, eax
    push eax            ; PUSH Length Counter

    ; WRITE STDOUT
    mov eax, 4  
    mov ebx, 1
    mov edx, 1
    int 80h

    pop eax             ; POP Length Counter
    pop ecx             ; POP Input

    cmp eax, 0
    jnz print_rev_loop

    print_rev_ret:
    ret

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
    buffer resb 11

section .rodata
newline:    db 0x0a