global main

extern printf
extern scanf
extern malloc

section .data
	_int db "%i", 0x0a, 0x00
	_int_scan db "%d", 0
section .text
main:
	push ebp
	mov	ebp, esp
	push 100
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	mov dword [ ebp - 8], 9
	mov dword eax, [ebp - 8]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 8], eax
	call func_array_func
	add esp, 2* 4
	mov [ebp - 4], eax
	mov dword eax, [ebp - 8]
	mov dword ebx, [ebp - 4]
	mov dword eax, [ebx + 18 * 4], 
	mov dword ecx, eax
	call syscall_print_int
	
	mov dword eax, [ebp - 4]
	mov dword ecx, [eax + 19 * 4], 
	mov dword [ ebp - 4], eax
	mov dword eax, ecx
	call syscall_print_int
	
	mov dword eax, [ebp - 4]
	mov dword ecx, [eax + 20 * 4], 
	mov dword [ ebp - 4], eax
	mov dword eax, ecx
	call syscall_print_int
	
	mov dword eax, [ebp - 4]
	mov dword ecx, [eax + 21 * 4], 
	mov dword [ ebp - 4], eax
	mov dword eax, ecx
	call syscall_print_int
	
	mov dword eax, [ebp - 4]
	mov dword ecx, [eax + 22 * 4], 
	mov dword [ ebp - 4], eax
	mov dword eax, ecx
	call syscall_print_int
	
	mov dword eax, [ebp - 4]
	mov dword ecx, [eax + 23 * 4], 
	mov dword [ ebp - 4], eax
	mov dword eax, ecx
	call syscall_print_int
	
	mov dword eax, [ebp - 4]
	mov dword ecx, [eax + 24 * 4], 
	mov dword [ ebp - 4], eax
	mov dword eax, ecx
	call syscall_print_int
	
	mov dword [ ebp - 8], ecx
	
	mov	esp, ebp
	pop ebp
	mov eax, 1
	int 0x80
func_array_func:
	push ebp
	mov	ebp, esp
	sub esp, 4
	mov dword [ ebp - 4], 0
	mov dword eax, [ebp - -8]
	mov dword [eax + 21 * 4], 5
	mov dword ecx, [ebp - -8]
	mov dword [ecx + 22 * 4], 1
	mov dword edx, [ebp - -8]
	mov dword [edx + 23 * 4], 2
	mov dword esi, [ebp - -8]
	mov dword [esi + 24 * 4], 3
	mov dword edi, [ebp - -8]
	mov dword [edi + 20 * 4], 4
	mov dword [ ebp - -8], edi
	mov dword eax, [ebp - -8]
	mov dword [eax + 19 * 4], 6
	mov dword edi, [ebp - -8]
	mov dword [edi + 18 * 4], 7
	mov dword [ ebp - -8], edi
	mov dword eax, [ebp - -12]
	mov dword edi, [ebp - -8]
	mov dword eax, [edi + 20 * 4], 
	mov dword [ ebp - -8], edi
	mov dword [ ebp - -12], eax
	mov eax, [ebp - -8]
	mov	esp, ebp
	pop ebp
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
