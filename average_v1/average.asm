section .text
global main

extern printf

main:
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
x dd 5, 3, 2, 6, 1, 7, 4
y dd 0, 10, 1, 9, 2, 8, 5
fstr db "Average: %d", 0xA, 0

section .bss
