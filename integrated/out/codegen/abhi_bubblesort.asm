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
func_bubblesort_sort:
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
	mov dword eax, [ ebp - -8]
	mov dword [ ebp - 12], 0
	mov dword [ ebp - 4], eax

label_13:
	mov dword [ ebp - 20], 1
	mov dword eax, [ebp - 12]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 12], eax
	jl label_17
	mov dword [ ebp - 20], 0

label_17:
	cmp dword [ ebp - 20], 0
	je label_99
	mov dword [ ebp - 16], 1

label_19:
	; HERE
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	sub dword eax, [ ebp - 12]
	mov dword [ ebp - 28], 1
	cmp dword [ ebp - 16], eax
	mov dword [ ebp - 24], eax
	jl label_25
	mov dword [ ebp - 28], 0

label_25:
	cmp dword [ ebp - 28], 0
	je label_95
	mov dword [ ebp - 32], 0
	; HERE
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 16], eax
	sub dword eax, 1
	cmp dword eax, 0
	mov dword [ ebp - 36], eax
	jge label_32
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_32:
	cmp dword [ ebp - 36], 7
	jl label_34
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_34:
	; HERE
	mov dword eax, [ebp - 32]
	add dword eax, [ ebp - 36]
	mov dword ecx, [ebp - -12]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 44], 0
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 32], eax
	mov dword [ ebp - 40], ebx
	jge label_41
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_41:
	cmp dword [ ebp - 16], 7
	jl label_43
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_43:
	; HERE
	mov dword eax, [ebp - 44]
	add dword eax, [ ebp - 16]
	mov dword ecx, [ebp - -12]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 52], 1
	cmp dword [ ebp - 40], ebx
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 44], eax
	mov dword [ ebp - 48], ebx
	jg label_50
	mov dword [ ebp - 52], 0

label_50:
	cmp dword [ ebp - 52], 1
	je label_52
	jmp label_91

label_52:
	mov dword [ ebp - 56], 0
	; HERE
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 16], eax
	sub dword eax, 1
	cmp dword eax, 0
	mov dword [ ebp - 60], eax
	jge label_58
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_58:
	cmp dword [ ebp - 60], 7
	jl label_60
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_60:
	; HERE
	mov dword eax, [ebp - 56]
	add dword eax, [ ebp - 60]
	mov dword ecx, [ebp - -12]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 64], ebx
	mov dword [ ebp - 68], 0
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 56], eax
	jge label_68
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_68:
	cmp dword [ ebp - 16], 7
	jl label_70
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_70:
	; HERE
	mov dword eax, [ebp - 68]
	mov dword ebx, [ ebp - 16]
	add dword eax, ebx
	mov dword edx, [ebp - -12]
	mov dword ecx, [edx + eax * 4]
	mov dword [ ebp - 76], 0
	; HERE
	mov dword [ ebp - 16], ebx
	sub dword ebx, 1
	cmp dword ebx, 0
	mov dword [ ebp - -12], edx
	mov dword [ ebp - 68], eax
	mov dword [ ebp - 72], ecx
	mov dword [ ebp - 80], ebx
	jge label_79
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_79:
	cmp dword [ ebp - 80], 7
	jl label_81
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_81:
	; HERE
	mov dword eax, [ebp - 76]
	add dword eax, [ ebp - 80]
	mov dword ebx, [ebp - 72]
	mov dword ecx, [ebp - -12]
	mov dword [ecx + eax * 4], ebx
	mov dword [ ebp - 84], 0
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 72], ebx
	mov dword [ ebp - 76], eax
	jge label_87
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_87:
	cmp dword [ ebp - 16], 7
	jl label_89
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_89:
	; HERE
	mov dword eax, [ebp - 84]
	add dword eax, [ ebp - 16]
	mov dword ebx, [ebp - 8]
	mov dword ecx, [ebp - -12]
	mov dword [ecx + eax * 4], ebx
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 84], eax

label_91:
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 88], eax
	inc dword eax
	mov dword [ ebp - 16], eax
	jmp label_19

label_95:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 92], eax
	inc dword eax
	mov dword [ ebp - 12], eax
	jmp label_13

label_99:
	mov dword esp, ebp
	pop ebp
	ret
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 28
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
	push 0
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 16]
	push eax
	mov dword [ ebp - 16], eax
	call func_bubblesort_bubblesort
	add esp, 1* 4
	mov dword eax, [ ebp - 16]
	mov dword ebx, 0
	; HERE
	add dword ebx, 0
	mov dword ecx, [ebp - 20]
	mov dword [ecx + ebx * 4], 7
	mov dword edx, 0
	; HERE
	add dword edx, 1
	mov dword [ecx + edx * 4], 6
	mov dword esi, 0
	; HERE
	add dword esi, 2
	mov dword [ecx + esi * 4], 5
	mov dword edi, 0
	; HERE
	add dword edi, 3
	mov dword [ecx + edi * 4], 4
	mov dword [ ebp - 12], eax
	mov dword eax, 0
	; HERE
	add dword eax, 4
	mov dword [ecx + eax * 4], 3
	mov dword [ ebp - 40], eax
	mov dword eax, 0
	; HERE
	add dword eax, 5
	mov dword [ecx + eax * 4], 2
	mov dword [ ebp - 44], eax
	mov dword eax, 0
	; HERE
	add dword eax, 6
	mov dword [ecx + eax * 4], 1
	mov dword [ ebp - 48], eax
	mov dword eax, [ebp - 12]
	push eax
	push ecx
	;-1
	push 7
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 28], edx
	mov dword [ ebp - 32], esi
	mov dword [ ebp - 36], edi
	call func_bubblesort_sort
	add esp, 2* 4
	mov dword [ ebp - 52], 0

label_148:
	mov dword [ ebp - 56], 1
	cmp dword [ ebp - 52], 7
	jl label_152
	mov dword [ ebp - 56], 0

label_152:
	cmp dword [ ebp - 56], 0
	je label_172
	mov dword [ ebp - 60], 0
	cmp dword [ ebp - 52], 0
	jge label_157
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_157:
	cmp dword [ ebp - 52], 7
	jl label_159
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_159:
	; HERE
	mov dword eax, [ebp - 60]
	add dword eax, [ ebp - 52]
	mov dword ecx, [ebp - 20]
	mov dword ebx, [ecx + eax * 4]
	mov dword edx, [ebp - 4]
	push edx
	push ebx
	mov dword [ ebp - 4], edx
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 60], eax
	mov dword [ ebp - 64], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 52]
	mov dword [ ebp - 68], eax
	inc dword eax
	mov dword [ ebp - 52], eax
	jmp label_148

label_172:
	mov dword esp, ebp
	pop ebp
	ret
func_bubblesort_bubblesort:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
