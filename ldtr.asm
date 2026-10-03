section .data

msg1 db "LDTR Selector : ",10
msgl1 equ $-msg1

msg2 db "Local Descriptor Table Register",10
msgl2 equ $-msg2


%macro operate 4
    mov rax,%1
    mov rdi,%2
    mov rsi,%3
    mov rdx,%4
    syscall
%endmacro


section .bss

ldtr   resw 1
temp16 resw 1
asc    resb 1


section .text

global _start

_start:

    operate 1,1,msg2,msgl2

    operate 1,1,msg1,msgl1

    ; Store LDTR selector
    mov rsi,ldtr
    sldt [rsi]

    ; Get LDTR selector
    mov ax,[rsi]

    ; Display selector
    call display16

    ; Exit
    operate 60,0,0,0


display16:

    mov bp,4

again2:

    rol ax,4

    mov [temp16],ax

    and ax,0FH

    cmp al,09H
    jbe skip16

    add al,07H

skip16:

    add al,30H

    mov [asc],al

    operate 1,1,asc,1

    mov ax,[temp16]

    dec bp

    jnz again2

    ret