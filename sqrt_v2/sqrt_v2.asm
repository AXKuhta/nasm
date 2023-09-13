section .text
global main

extern printf

main:
	;
	; x87 fpu 80 bit square root
	;

	push rbp				; printf clobbers rbp
	sub rsp, 16				; printf %Lf will read 16 bytes of stack
	fld tword [number]
	fsqrt
	fstp tword [rsp]
	mov edi, fstr
	call printf
	add rsp, 16
	pop rbp
	ret

section .data
number dt 144.0
fstr db "Square root: %.20Lf", 0xA, 0

section .bss
