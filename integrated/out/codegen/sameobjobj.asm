global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
	_int db "%i", 0x00
	_float db "%f", 0
	__dummy_float dq 0.0
	_float_in db "%lf", 0
	_int_in db "%i", 0
	_char db "%c", 0
	_char_in db "%c", 0


section .text

main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 0
	call malloc
	add esp, 4
	mov [ebp -8], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - 8], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ ebp - 8]
	mov [ebp - 4], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 16]
	push eax
	mov dword [ ebp - 16], eax
	call func_rec1_rec1
	add esp, 1* 4
	mov dword eax, [ ebp - 16]
	mov [ebp - 12], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -20], eax
	mov dword eax, [ebp - 20]
	push eax
	mov dword [ ebp - 20], eax
	call func_rec1_rec1
	add esp, 1* 4
	;mem
	;t6
	mov dword eax, [ebp - 20]
	mov dword ebx, [ebp - 12]
	mov dword [ebx+4], eax
	mov ecx, [ebx+4]
	mov dword [ecx+0], 6
	mov edx, [ebx+4]
	mov esi, [edx+0]
	mov dword edi, [ebp - 4]
	push edi
	push esi
	mov dword [ ebp - 4], edi
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 20], eax
	mov dword [ ebp - 28], ecx
	mov dword [ ebp - 36], edx
	mov dword [ ebp - 40], esi
	call func_IO_print_int
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_rec1_rec1:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 43
	mov ecx, [ebx+4]
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], ecx
	mov dword esp, ebp
	pop ebp
	ret

func_IO_IO:
	ret
func_IO_print_char:
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	mov edx, 0
	mov ebx, 128
	div ebx
	push edx
	push _char
	call printf
	mov esp, ebp
	pop ebp
	ret
func_IO_print_int:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	push eax
	push _int
	call printf
	mov esp, ebp
	pop ebp
	ret
func_IO_print_float:
	push ebp
	mov ebp, esp
	fld dword [ebp + 8]
	sub esp, 8
	fstp qword [esp]
	push _float
	call printf
	mov esp, ebp
	pop ebp
	ret
func_IO_scan_char:
	push ebp
	mov ebp, esp
	sub esp, 4
	push esp
	push _char_in
	call scanf
	mov dword eax, [ebp - 4]
	mov esp, ebp
	pop ebp
	ret
func_IO_scan_int:
	push ebp
	mov ebp, esp
	sub esp, 4
	push esp 
	push _int_in
	call scanf
	mov eax, [ebp - 4]
	mov esp, ebp
	pop ebp
	ret
func_IO_scan_float:
	push ebp
	mov ebp, esp
	push __dummy_float
	push _float_in
	call scanf
	fld qword [__dummy_float]
	mov esp, ebp
	pop ebp
	ret
