section .data
    num1 db 52h
    num2 db 6Ah

    msg1 db "52h is the largest",10
    len1 equ $-msg1

    msg2 db "6Ah is the largest",10
    len2 equ $-msg2

%macro print 4
    mov rax,%1
    mov rdi,%2
    mov rsi,%3
    mov rdx,%4
    syscall
%endmacro

section .text
global _start

_start:

    mov al,[num1]      ; Load first number into AL
    mov bl,[num2]      ; Load second number into BL

    cmp al,bl          ; Compare AL with BL

    ja first           ; Jump if AL > BL
                       ; (Unsigned comparison)

    ; Otherwise BL is larger
    print 1,1,msg2,len2
    jmp exit

first:
    print 1,1,msg1,len1

exit:
    mov rax,60
    mov rdi,0
    syscall