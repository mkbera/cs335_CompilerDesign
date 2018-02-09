global main
section .data
	a	DD	0
	b	DD	0
section .text
main:
	mov dword eax, 3
	mov dword ebx, 3
	cmp dword eax, ebx
	je label_7
	
	mov dword [a], eax
	mov dword [b], ebx
	
	mov dword [a], 5
	call func_foo
	jmp label_8
	
	
label_7:
	mov dword [a], 10
	
	
label_8:
	
	mov eax, 1
	int 0x80
	
	
func_foo:
	mov dword [b], 5
	ret
	
	
syscall_print_int:
	push ebp
	mov ebp, esp
	push eax
	push _int
	call printf
	mov eax, 0
	mov esp, ebp
	pop ebp
	ret
