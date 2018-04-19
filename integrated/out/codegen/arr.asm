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
	push 8
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
	mov dword eax, 0
	add dword eax, 0
	mov dword ebx, [ebp - 4]
	mov dword [ebx + eax * 4], 69
	mov dword [ ebp - 12], 20
	mov dword ecx, 0
	add dword ecx, 0
	mov dword edx, [ebx + ecx * 4]
	mov dword [ ebp - 20], edx
	mov dword esi, 0
	add dword esi, 1
	mov dword [ebx + esi * 4], edx
	mov dword edi, 0
	add dword edi, 0
	mov dword [ ebp - 8], eax
	mov dword eax, [ebx + edi * 4]
	mov dword [ ebp - 36], eax
	mov dword [ ebp - 28], eax
	mov dword eax, 0
	add dword eax, 1
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 16], ecx
	mov dword ecx, [ebp - 4]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 48], ebx
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 12], edx
	mov dword [ ebp - 24], esi
	mov dword [ ebp - 32], edi
	mov dword [ ebp - 40], ebx
	mov dword [ ebp - 44], eax
	mov dword esp, ebp
	pop ebp
	ret
func_arr_arr:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
