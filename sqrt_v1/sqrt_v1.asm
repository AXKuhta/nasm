section .text
global main

extern printf

main:
	;
	; approx square root
	;

	; rbx = x1
	; rax = x2
	mov rbx, [number]		; x1 = number
	sar rbx, 1				; x1 /= 2

	.loop:
		mov rax, [number]	; x2 = number
		cqo					; rax sign -> rdx
		idiv rbx			; x2 /= x1
		add rax, rbx		; x2 += x1
		sar rax, 1			; x2 /= 2

		cmp rbx, rax
		jle .done
		mov rbx, rax		; x1 = x2
	jmp .loop
	.done:

	push rbp				; printf clobbers rbp
	mov rsi, rax
	mov edi, fstr
	call printf
	pop rbp

	mov rax, 60
	mov rdi, 0
	syscall

section .data
number dq 144
fstr db "Square root: %ld", 0xA, 0

section .bss
