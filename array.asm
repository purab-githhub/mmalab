section .data
    new_array db 12h,62h,25h,24h,97h
    msg db "result of array addition is "
    msglen equ $-msg
    newline db 10

section .bss
    result resw 1
    temp1 resb 1

%macro concat 4;macro is uded for not repeating the system call again and again
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro

section .text
    global _start

_start:
    ; 1. Calculate Array Addition
    mov rsi, new_array
    mov ax, 00h
    mov bx, 0h
    mov cx, 5

up2:
    mov bl, byte[rsi]
    add ax, bx
    inc rsi
    dec cx
    jnz up2

    mov word [result], ax

    ; 2. Print Message Header
    concat 1, 1, msg, msglen

    ; 3. Convert and Print Hex Output
    mov ax, word[result]
    mov bp, 4

up:
    rol ax, 4
    mov bx, ax
    and al, 0Fh
    cmp al, 09h
    jbe down
    add al, 07h

down:
    add al, 30h
    mov byte[temp1], al       ; Store converted ASCII character
   
    push rax                  ; Save AX across syscall
    concat 1, 1, temp1, 1     ; Print single ASCII digit
    pop rax                   ; Restore AX
   
    mov ax, bx                ; Restore rotated value
    dec bp
    jnz up

    ; 4. Print Newline
    concat 1, 1, newline, 1

    ; 5. Exit Cleanly
    concat 60, 0, 0, 0
    