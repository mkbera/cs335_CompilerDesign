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
	mov dword [ ebp - 4], 5
	push 0
	call malloc
	add esp, 4
	mov [ebp -28], eax
	mov dword eax, [ebp - 28]
	push eax
	mov dword [ ebp - 28], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ ebp - 28]
	mov dword [ ebp - 8], 0
	mov dword [ ebp - 24], eax

label_17:
	mov dword [ ebp - 32], 1
	mov dword eax, [ebp - 8]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 8], eax
	jl label_21
	mov dword [ ebp - 32], 0

label_21:
	cmp dword [ ebp - 32], 0
	je label_37
	mov dword eax, [ebp - 24]
	push eax
	mov dword [ ebp - 24], eax
	call func_IO_scan_float
	add esp, 1* 4
	fstp dword [ebp - 36]
	mov dword [ ebp - 40], 0
	cmp dword [ ebp - 8], 0
	jge label_29
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_29:
	cmp dword [ ebp - 8], 5
	jl label_31
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_31:
	mov dword eax, [ebp - 40]
	mov dword ebx, [ ebp - 8]
	add dword eax, ebx
	fld dword [ebp -36]
	mov dword ecx, [ebp - 20]
	fstp dword [ecx + eax * 4]
	mov dword edx, ebx
	add dword ebx, 1
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 40], eax
	mov dword [ ebp - 44], edx
	jmp label_17

label_37:
	mov dword [ ebp - 8], 0

label_38:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	sub dword eax, 1
	mov dword [ ebp - 52], 1
	cmp dword [ ebp - 8], eax
	mov dword [ ebp - 48], eax
	jl label_44
	mov dword [ ebp - 52], 0

label_44:
	cmp dword [ ebp - 52], 0
	je label_128
	mov dword [ ebp - 12], 0

label_46:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	sub dword eax, [ ebp - 8]
	mov dword [ ebp - 56], eax
	sub dword eax, 1
	mov dword [ ebp - 64], 1
	cmp dword [ ebp - 12], eax
	mov dword [ ebp - 60], eax
	jl label_54
	mov dword [ ebp - 64], 0

label_54:
	cmp dword [ ebp - 64], 0
	je label_124
	mov dword [ ebp - 68], 0
	cmp dword [ ebp - 12], 0
	jge label_59
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_59:
	cmp dword [ ebp - 12], 5
	jl label_61
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_61:
	mov dword eax, [ebp - 68]
	mov dword ebx, [ ebp - 12]
	add dword eax, ebx
	mov dword ecx, [ebp - 20]
	fld dword [ecx + eax * 4]
	fstp dword [ebp - 72]
	mov dword [ ebp - 76], 0
	mov dword [ ebp - 12], ebx
	add dword ebx, 1
	cmp dword ebx, 0
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 68], eax
	mov dword [ ebp - 80], ebx
	jge label_70
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_70:
	cmp dword [ ebp - 80], 5
	jl label_72
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_72:
	mov dword eax, [ebp - 76]
	add dword eax, [ ebp - 80]
	mov dword ebx, [ebp - 20]
	fld dword [ebx + eax * 4]
	fstp dword [ebp - 84]
	mov dword [ ebp - 88], 1
	fld dword [ebp -84]
	fld dword [ebp - 72]
	fcompp
	fstsw ax
	fwait
	sahf
	ja label_79
	mov dword [ ebp - 88], 0
	mov dword [ ebp - 20], ebx
	mov dword [ ebp - 76], eax

label_79:
	cmp dword [ ebp - 88], 1
	je label_81
	jmp label_120

label_81:
	mov dword [ ebp - 92], 0
	cmp dword [ ebp - 12], 0
	jge label_85
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_85:
	cmp dword [ ebp - 12], 5
	jl label_87
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_87:
	mov dword eax, [ebp - 92]
	mov dword ebx, [ ebp - 12]
	add dword eax, ebx
	mov dword ecx, [ebp - 20]
	fld dword [ecx + eax * 4]
	fstp dword [ebp - 96]
	fld dword [ebp -96]
	fstp dword [ebp - 16]
	mov dword [ ebp - 100], 0
	mov dword [ ebp - 12], ebx
	add dword ebx, 1
	cmp dword ebx, 0
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 92], eax
	mov dword [ ebp - 104], ebx
	jge label_97
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_97:
	cmp dword [ ebp - 104], 5
	jl label_99
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_99:
	mov dword eax, [ebp - 100]
	add dword eax, [ ebp - 104]
	mov dword ebx, [ebp - 20]
	fld dword [ebx + eax * 4]
	fstp dword [ebp - 108]
	mov dword [ ebp - 112], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - 20], ebx
	mov dword [ ebp - 100], eax
	jge label_106
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_106:
	cmp dword [ ebp - 12], 5
	jl label_108
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_108:
	mov dword eax, [ebp - 112]
	mov dword ebx, [ ebp - 12]
	add dword eax, ebx
	fld dword [ebp -108]
	mov dword ecx, [ebp - 20]
	fstp dword [ecx + eax * 4]
	mov dword [ ebp - 116], 0
	mov dword [ ebp - 12], ebx
	add dword ebx, 1
	cmp dword ebx, 0
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 112], eax
	mov dword [ ebp - 120], ebx
	jge label_116
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_116:
	cmp dword [ ebp - 120], 5
	jl label_118
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_118:
	mov dword eax, [ebp - 116]
	add dword eax, [ ebp - 120]
	fld dword [ebp -16]
	mov dword ebx, [ebp - 20]
	fstp dword [ebx + eax * 4]
	mov dword [ ebp - 20], ebx
	mov dword [ ebp - 116], eax

label_120:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 124], eax
	add dword eax, 1
	mov dword [ ebp - 12], eax
	jmp label_46

label_124:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 128], eax
	add dword eax, 1
	mov dword [ ebp - 8], eax
	jmp label_38

label_128:
	mov dword [ ebp - 132], 0

label_130:
	mov dword [ ebp - 136], 1
	mov dword eax, [ebp - 132]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 132], eax
	jl label_134
	mov dword [ ebp - 136], 0

label_134:
	cmp dword [ ebp - 136], 0
	je label_154
	mov dword [ ebp - 140], 0
	cmp dword [ ebp - 132], 0
	jge label_139
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_139:
	cmp dword [ ebp - 132], 5
	jl label_141
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_141:
	mov dword eax, [ebp - 140]
	add dword eax, [ ebp - 132]
	mov dword ebx, [ebp - 20]
	fld dword [ebx + eax * 4]
	fstp dword [ebp - 144]
	mov dword ecx, [ebp - 24]
	push ecx
	sub esp, 4
	fld dword [ebp - 144]
	fstp dword [esp]
	mov dword [ ebp - 20], ebx
	mov dword [ ebp - 24], ecx
	mov dword [ ebp - 140], eax
	call func_IO_print_float
	add esp, 1* 4
	mov dword eax, [ebp - 24]
	push eax
	;-1
	push 10
	mov dword [ ebp - 24], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 132]
	mov dword [ ebp - 148], eax
	add dword eax, 1
	mov dword [ ebp - 132], eax
	jmp label_130

label_154:
	mov dword esp, ebp
	pop ebp
	ret
func_BubbleSort_BubbleSort:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
