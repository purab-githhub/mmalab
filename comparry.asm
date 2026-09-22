;jbe  is less than aur equal to the num2
;jae is the number is equal or above the num2
;rsi is inc if no swap
;xchg for swapping


section .data
nw_array db 12h,62h,25h,25h,03h
msg db "the comparison of the whole array elements"
msglen equ $-msg,10

section .bss
arry resw 2
temporary_variable resb 1


%macro comp 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
%endmacro

section .text
global _start
_start:
mov rsi,byte[nw_array]
                           

