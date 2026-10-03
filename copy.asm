section .data
;pehle tho doo cheez dalenge 
;error message
;copying the file wala 
 msg1 db "error",10
 msg1len equ $-msg1
 msg2 db "file copy successfully",10
 msg2len equ $-msg2
 
%macro operate 4
 mov rax,%1
 mov rdi,%2
 mov rsi,%3
 mov rdx,%4
 syscall
%endmacro

;kya kya chaiye file opem file des dono source ke liye and destination ke liye 

section .bss
 file1 resb 15
 fd1 resq 1 
 file2 resb 15
 fd2 resq 1 
 buffer resb 512 
 bufferlen resq 1 
 
bits 64 
section .text
 global _start

_start:
 pop r8
 ;ussko compare karge na argv[0,1,2] teen hain na bhai 
 cmp r8,3
 jne err

 pop r8 
 pop r8 

 mov rsi,file1 ;these retrieve karega command line addresses 
 ;argv copy program hoga 
 ;ofilee.txt ko accress karega seconf pop mein into the rsi
 ;address

above:
 mov al,[r8]
 ;ek karke dalenge abhi hum 
 cmp al,00
 je next
 mov [rsi],al 
 ;abh ek karke jaara hain rsi mein 
 ; o f i l e e t x t 
 inc r8
 inc rsi 
 jmp above 
 
next:
 mov byte [rsi],0

 pop r8 ;seconf dile destination vale 
 mov rsi,file2

above2:
 mov al,[r8]
 cmp al,00
 je next2
 mov [rsi],al
 inc r8 
 inc rsi 
 jmp above2 

next2:
 mov byte [rsi],0

;now comes to the actual file copying 
;tho pehle file open karna padega

 operate 2,file1,0,0
 mov [fd1],rax

 operate 0,[fd1],buffer,512
 mov [bufferlen],rax

 ;abh kaya hain read kara hain from the open file 
 ;ka data into the memory 

 ;destination file create karenge

 operate 85,file2,0777q,0
 mov [fd2],rax

 operate 1,[fd2],buffer,[bufferlen]

 operate 3,[fd2],0,0
 operate 3,[fd1],0,0

 operate 1,1,msg2,msg2len
 jmp end

err:
 operate 1,1,msg1,msg1len

end:
 operate 60,0,0,0