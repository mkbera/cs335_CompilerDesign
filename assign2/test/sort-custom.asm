global main

extern printf
extern scanf

section .data
	_int db "%i", 0x0a, 0x00
	_int_scan db "%d", 0
	n	DD	0
	i	DD	0
	t	DD	0
	j	DD	0
	x	DD	0
	y	DD	0
	arr	TIMES	100	DD	0
section .text
main:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp
	mov ebp, esp
	push n
	push _int_scan
	call scanf
	mov esp, ebp
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	mov dword ebx, [n]
	mov dword eax, ebx
	call syscall_print_int
	
	cmp dword ebx, 100
	jg label_12
	mov dword [i], 0

label_6:
	mov dword eax, [i]
	cmp dword eax, [n]
	mov dword [i], eax
	je label_11
	
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp
	mov ebp, esp
	push t
	push _int_scan
	call scanf
	mov esp, ebp
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	mov dword eax, [i]
	mov dword ebx, [t]
	mov dword [arr + 4*eax], ebx
	add dword eax, 1
	mov dword [i], eax
	mov dword [t], ebx
	jmp label_6

label_11:
	call func_print_array

label_12:
	mov dword [i], 0
	sub	dword [n], 1

label_14:
	mov dword eax, [i]
	cmp dword eax, [n]
	je label_29
	mov dword [j], 0
	mov dword eax, [n]
	sub dword eax, [i]
	mov dword [t], eax

label_17:
	mov dword eax, [j]
	cmp dword eax, [t]
	je label_27
	mov dword ebx, [j]
	mov dword eax, [arr + 4*ebx]
	add dword ebx, 1
	mov dword ecx, [arr + 4*ebx]
	cmp dword eax, ecx
	mov dword [j], ebx
	mov dword [x], eax
	mov dword [y], ecx
	jle label_17
	mov dword eax, [j]
	mov dword ebx, [x]
	mov dword [arr + 4*eax], ebx
	sub dword eax, 1
	mov dword ecx, [y]
	mov dword [arr + 4*eax], ecx
	add dword eax, 1
	mov dword [j], eax
	jmp label_17

label_27:
	add dword [i], 1
	jmp label_14

label_29:
	add dword [n], 1
	call func_print_array
	
	mov eax, 1
	int 0x80
func_print_array:
	mov dword [i], 0

label_34:
	mov dword eax, [i]
	cmp dword eax, [n]
	mov dword [i], eax
	je label_39
	mov dword ebx, [i]
	mov dword eax, [arr + 4*ebx]
	mov dword [t], eax
	call syscall_print_int
	
	add dword ebx, 1
	mov dword [i], ebx
	jmp label_34

label_39:
	ret

syscall_print_int:
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp
	mov ebp, esp
	push eax
	push _int
	call printf
	mov eax, 0
	mov esp, ebp
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	ret
