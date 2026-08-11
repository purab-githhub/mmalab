section .data
;we need to have an list of aaray

arr db 12h,62h,22h,25h,03h

section .text
global _start:
_start:

mov rdx,4; as we know that sorting goes from til n-1

again:
mov rsi,0   ;i have to actual access the indexes only for the comparison to actuall acess the element at that indexes

;now u just have to add the elements to the registers or load the registers with the element

next:

mov al,[arr + rsi]; //access the first element

mov bl,[arr+rsi+1];//accessing the second element
;ow we have to compare the registers which contain the elements

cmp al,bl

jbe skip ;i have to jump if equal so it will just inc the rsi only 

; i just have to know swap
mov [arr+rsi+1],al
mov [arr+rsi],bl
;if my index+1 is grater  than index current then shift or swap

skip:
inc rsi
cmp rsi, rdx
    jb next

    dec rdx
    jnz again

    mov rax, 60
    mov rdi, 0
    syscall