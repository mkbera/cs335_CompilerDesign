global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
	_int db "%i", 0x0a, 0x00
	_float db "%f", 0xA, 0
	__dummy_float dq 0.0
	_float_in db "%lf", 0
	_int_in db "%i", 0
	_char db "%c", 10, 0


section .text

main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
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
	mov dword ebx, 0
	add dword ebx, 0
	mov dword ecx, [ebp - 12]
	mov dword [ecx + ebx * 4], 1
	mov dword [ ebp - 20], 0
	mov dword edx, 0
	add dword edx, 0
	mov dword esi, [ecx + edx * 4]
	mov dword [ ebp - 28], esi
	mov dword edi, 0
	add dword edi, 1
	mov dword [ecx + edi * 4], esi
	mov dword [ ebp - 36], 0
	mov dword [ ebp - 4], eax
	mov dword eax, 1
	cmp dword eax, 1
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 20], esi
	mov dword [ ebp - 24], edx
	mov dword [ ebp - 32], edi
	mov dword [ ebp - 40], eax
	je label_33
	jmp label_38

label_33:
	mov dword [ ebp - 44], 5
	mov dword eax, [ebp - 4]
	push eax
	mov dword ebx, [ebp - 44]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 44], ebx
	call func_IO_print_int
	add esp, 2* 4

label_38:
	mov dword esp, ebp
	pop ebp
	ret
func_arr_arr:
	push ebp
	mov ebp, esp
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
