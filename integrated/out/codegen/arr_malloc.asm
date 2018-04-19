global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
		_int db "%i", 0
		_float db "%f", 0
		__dummy_float dq 0.0
		_float_in db "%lf", 0
		_int_in db "%i", 0
		_char db "%c", 0
		_char_in db "%c", 0
		_43	DD 1.0
		_45	DD 1.0
		_47	DD 1.0


section .text

	
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
		mov edx, 0
		mov ebx, 128
		div ebx
		mov eax, edx
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
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 24
	call malloc
	add esp, 4
	push eax
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
	mov dword [ ebp - 12], 6
	mov dword ebx, 0
	add dword ebx, 0
	mov dword ecx, [ebp - 16]
	mov dword [ecx + ebx * 4], 69
	mov dword edx, 20
	mov dword esi, 0
	add dword esi, 1
	mov dword [ecx + esi * 4], edx
	mov dword edi, 0
	add dword edi, 0
	mov dword [ ebp - 4], eax
	mov dword eax, [ecx + edi * 4]
	mov dword [ ebp - 40], eax
	mov dword [ ebp - 32], eax
	mov dword eax, 0
	add dword eax, 1
	mov dword [ ebp - 20], ebx
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 52], ebx
	mov dword [ ebp - 48], eax
	mov dword eax, [ebp - 4]
	push eax
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 16], ecx
	mov dword [ ebp - 24], edx
	mov dword [ ebp - 28], esi
	mov dword [ ebp - 36], edi
	mov dword [ ebp - 44], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	fld dword [_43]
	fstp dword [ebp - 56]
	fld dword [_45]
	fstp dword [ebp - 60]
	fld dword [_47]
	fstp dword [ebp - 64]
	fild dword [ebp - 24]
	fstp dword [ebp - 72]
	fld dword [ebp -72]
	fld dword [ebp -56]
	fmul st0, st1
	fstp dword [ebp - 68]
	fstp st0
	fld dword [ebp -68]
	fstp dword [ebp - 64]
	mov dword eax, [ebp - 4]
	push eax
	sub esp, 4
	fld dword [ebp - 64]
	fstp dword [esp]
	mov dword [ ebp - 4], eax
	call func_IO_print_float
	add esp, 1* 4
	mov dword esp, ebp
	pop ebp
	ret
func_arr_arr:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
