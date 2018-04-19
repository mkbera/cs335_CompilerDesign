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
	sub esp, 4
	sub esp, 4
	push 20
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
	mov dword [ ebp - 16], 0
	mov dword [ ebp - 4], eax

label_15:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 16], 5
	jl label_19
	mov dword [ ebp - 20], 0

label_19:
	cmp dword [ ebp - 20], 0
	je label_36
	push 8
	call malloc
	add esp, 4
	mov [ebp -24], eax
	mov dword eax, [ebp - 24]
	push eax
	mov dword [ ebp - 24], eax
	call func_rec_rec
	add esp, 1* 4
	mov dword [ ebp - 28], 0
	cmp dword [ ebp - 16], 0
	jge label_28
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_28:
	cmp dword [ ebp - 16], 5
	jl label_30
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_30:
	mov dword eax, [ebp - 28]
	mov dword ebx, [ ebp - 16]
	add dword eax, ebx
	mov dword ecx, [ebp - 24]
	mov dword edx, [ebp - 12]
	mov dword [edx + eax * 4], ecx
	mov dword esi, ebx
	add dword ebx, 1
	mov dword [ ebp - 12], edx
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 24], ecx
	mov dword [ ebp - 28], eax
	mov dword [ ebp - 32], esi
	jmp label_15

label_36:
	mov dword [ ebp - 36], 0

label_38:
	mov dword [ ebp - 40], 1
	cmp dword [ ebp - 36], 5
	jl label_42
	mov dword [ ebp - 40], 0

label_42:
	cmp dword [ ebp - 40], 0
	je label_77
	mov dword [ ebp - 44], 0
	cmp dword [ ebp - 36], 0
	jge label_47
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_47:
	cmp dword [ ebp - 36], 5
	jl label_49
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_49:
	mov dword eax, [ebp - 44]
	add dword eax, [ ebp - 36]
	mov dword ecx, [ebp - 12]
	mov dword ebx, [ecx + eax * 4]
	mov edx, [ebx+0]
	mov dword esi, [ebp - 4]
	push esi
	push edx
	mov dword [ ebp - 4], esi
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 44], eax
	mov dword [ ebp - 48], ebx
	mov dword [ ebp - 52], edx
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, 0
	add dword eax, 1
	mov dword ecx, [ebp - 12]
	mov dword ebx, [ecx + eax * 4]
	mov edx, [ebx+4]
	mov dword esi, [ebp - 4]
	push esi
	push edx
	mov dword [ ebp - 4], esi
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 56], eax
	mov dword [ ebp - 60], ebx
	mov dword [ ebp - 64], edx
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 36]
	mov dword [ ebp - 68], eax
	add dword eax, 1
	mov dword [ ebp - 36], eax
	jmp label_38

label_77:
	mov dword esp, ebp
	pop ebp
	ret
func_rec_rec:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 9
	mov ecx, [ebx+4]
	mov dword [ebx+4], 10
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], ecx
	mov dword esp, ebp
	pop ebp
	ret
