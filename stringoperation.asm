%macro rw 4
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro


section .data

    msg1 db "Enter first string: "
    len1 equ $-msg1

    msg2 db "Enter second string: "
    len2 equ $-msg2

    msg_cat db 10, "Concatenated string: "
    lencat equ $-msg_cat

    msg_sub db 10, "Substrings found: "
    lensub equ $-msg_sub

    newline db 10


section .bss

    str1 resb 100
    str2 resb 100
    str3 resb 200

    l1 resb 1
    l2 resb 1
    l3 resb 1

    count resb 1
    temp resb 1


section .text

global _start

_start:

    rw 1, 1, msg1, len1
    rw 0, 0, str1, 100
    dec rax
    mov [rel l1], al

    rw 1, 1, msg2, len2
    rw 0, 0, str2, 100
    dec rax
    mov [rel l2], al


    mov rsi, str1
    mov rdi, str3
    xor rcx, rcx
    mov cl, [rel l1]
    rep movsb

    mov rsi, str2
    xor rcx, rcx
    mov cl, [rel l2]
    rep movsb


    mov al, [rel l1]
    add al, [rel l2]
    mov [rel l3], al


    rw 1, 1, msg_cat, lencat

    mov rsi, str3
    xor rdx, rdx
    mov dl, [rel l3]

    rw 1, 1, rsi, rdx


    mov byte [rel count], 0

    mov al, [rel l1]
    sub al, [rel l2]

    jc display_sub_count

    inc al
    mov [rel temp], al

    mov rsi, str1


outer_loop:

    push rsi

    mov rdi, str2
    xor rcx, rcx
    mov cl, [rel l2]

    repe cmpsb

    je found_substring

    pop rsi

    inc rsi

    dec byte [rel temp]
    jnz outer_loop

    jmp display_sub_count


found_substring:

    inc byte [rel count]

    pop rsi
    inc rsi

    dec byte [rel temp]
    jnz outer_loop


display_sub_count:

    rw 1, 1, msg_sub, lensub

    mov al, [rel count]
    and al, 0Fh

    call conversion_to_ascii

    mov [rel temp], al

    rw 1, 1, temp, 1

    rw 1, 1, newline, 1

    rw 60, 0, 0, 0


conversion_to_ascii:

    cmp al, 09h
    jbe add_zero

    add al, 07h

add_zero:

    add al, 30h
    ret