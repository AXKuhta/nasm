section .text
global main

extern printf
extern strtol

main:
	;
	; Read file
	;

	mov rax, 2				; syscall 2 = open()
	mov rdi, path			; filename = "data.txt\0"
	mov rsi, 0				; flags = 0
	mov rdx, 0				; mode = O_RDONLY
	syscall					; rax = fd

	mov rdi, rax			; fd
	mov rax, 0				; syscall 0 = read()
	mov rsi, buffer			; buf = buffer
	mov rdx, 4096			; count = 4096
	syscall

	;
	; Parse x
	;

	mov rbp, x
	add rbp, 28
	mov rbx, x
	mov qword [lastpos], buffer

	.read_x:
		mov rdi, [lastpos]	; char* nptr = lastpos
		mov rsi, lastpos	; char** endptr = &lastpos
		xor edx, edx		; base = 0
		call strtol			; strtol()
		mov [rbx], eax		; save
		inc qword [lastpos]	; skip , or \n
		add rbx, 4			; i++
		cmp rbx, rbp
	jne .read_x

	;
	; Parse y
	;

	mov rbp, y
	add rbp, 28
	mov rbx, y

	.read_y:
		mov rdi, [lastpos]	; char* nptr = lastpos
		mov rsi, lastpos	; char** endptr = &lastpos
		xor edx, edx		; base = 0
		call strtol			; strtol()
		mov [rbx], eax		; save
		inc qword [lastpos]	; skip , or \n
		add rbx, 4			; i++
		cmp rbx, rbp
	jne .read_y

	xor rax, rax
	xor rcx, rcx

	; Sum
	.loop:
		add eax, dword [x + 4*rcx]
		sub eax, dword [y + 4*rcx]
		inc rcx
		cmp rcx, 7
	jne .loop

	mov rcx, 7				; load divisor
	cdq						; eax sign -> edx
	idiv ecx				; signed division

	push rbp				; printf clobbers rbp
	mov esi, eax
	mov edi, fstr
	call printf
	pop rbp

	mov rax, 60
	mov rdi, 0
	syscall

section .data
path db "data.txt", 0
fstr db "Average: %d", 0xA, 0

section .bss
buffer resb 4096
lastpos resq 1
x resd 7
y resd 7
