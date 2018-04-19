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
		_34 DD 0
		_42 DD 0
		_76 DD 10
		_108 DD 0
		_111 DD 10.0


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
func_List_set_next:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	;mem
	;next_8
	mov dword eax, [ebp - -8]
	mov dword ebx, [ebp - -12]
	mov dword [ebx+8], eax
	mov dword [ebx+4], 1
	mov dword [ ebp - -8], eax
	mov dword [ ebp - -12], ebx
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
	push 12
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 4]
	push eax
	mov dword [ ebp - 4], eax
	call func_IO_scan_float
	add esp, 1* 4
	fstp dword [ebp - 20]
	mov dword eax, [ebp - 16]
	push eax
	sub esp, 4
	fld dword [ebp - 20]
	fstp dword [esp]
	mov dword [ ebp - 16], eax
	call func_List_List
	add esp, 1* 4
	mov dword eax, [ ebp - 16]
	mov dword [ ebp - 12], eax
	fild dword [_34]
	fstp dword [ebp - 32]
	fld dword [ebp -32]
	fstp dword [ebp - 28]
	mov dword [ ebp - 24], eax

label_37:
	mov dword eax, [ebp - 4]
	push eax
	mov dword [ ebp - 4], eax
	call func_IO_scan_float
	add esp, 1* 4
	fstp dword [ebp - 36]
	fld dword [ebp -36]
	fstp dword [ebp - 28]
	fild dword [_42]
	fstp dword [ebp - 44]
	mov dword [ ebp - 40], 1
	fld dword [ebp -44]
	fld dword [ebp - 28]
	fcompp
	fstsw ax
	fwait
	sahf
	jae label_47
	mov dword [ ebp - 40], 0

label_47:
	cmp dword [ ebp - 40], 0
	je label_66
	mov dword eax, [ebp - 4]
	push eax
	sub esp, 4
	fld dword [ebp - 28]
	fstp dword [esp]
	mov dword [ ebp - 4], eax
	call func_IO_print_float
	add esp, 1* 4
	mov dword eax, [ebp - 4]
	push eax
	sub esp, 4
	fld dword [ebp - 28]
	fstp dword [esp]
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	push 12
	call malloc
	add esp, 4
	mov [ebp -48], eax
	mov dword eax, [ebp - 48]
	push eax
	sub esp, 4
	fld dword [ebp - 28]
	fstp dword [esp]
	mov dword [ ebp - 48], eax
	call func_List_List
	add esp, 1* 4
	mov dword eax, [ebp - 24]
	push eax
	mov dword ebx, [ebp - 48]
	push ebx
	mov dword [ ebp - 24], eax
	mov dword [ ebp - 48], ebx
	call func_List_set_next
	add esp, 2* 4
	mov dword ebx, [ebp - 24]
	mov eax, [ebx+8]
	mov dword ebx, eax
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 52], eax
	jmp label_37

label_66:
	mov dword eax, [ ebp - 12]
	mov dword ebx, [ebp - 4]
	push ebx
	;-1
	push 10
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 24], eax
	call func_IO_print_char
	add esp, 1* 4

label_70:
	mov dword ebx, [ebp - 24]
	mov eax, [ebx+4]
	cmp dword eax, 0
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 56], eax
	je label_103
	mov dword eax, [ebp - 24]
	fld dword [eax+0]
	fstp dword [ebp - 60]
	fild dword [_76]
	fstp dword [ebp - 68]
	mov dword [ ebp - 64], 1
	fld dword [ebp -68]
	mov dword [ ebp - 24], eax
	fld dword [ebp - 60]
	fcompp
	fstsw ax
	fwait
	sahf
	jb label_81
	mov dword [ ebp - 64], 0

label_81:
	cmp dword [ ebp - 64], 1
	je label_88
	mov dword eax, [ebp - 24]
	fld dword [eax+0]
	fstp dword [ebp - 72]
	mov dword ebx, [ebp - 4]
	push ebx
	sub esp, 4
	fld dword [ebp - 72]
	fstp dword [esp]
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 24], eax
	call func_IO_print_float
	add esp, 1* 4
	jmp label_96

label_88:
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 32
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 24]
	fld dword [eax+0]
	fstp dword [ebp - 76]
	mov dword ebx, [ebp - 4]
	push ebx
	sub esp, 4
	fld dword [ebp - 76]
	fstp dword [esp]
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 24], eax
	call func_IO_print_float
	add esp, 1* 4

label_96:
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword ebx, [ebp - 24]
	mov eax, [ebx+8]
	mov dword ebx, eax
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 80], eax
	jmp label_70

label_103:
	mov dword esp, ebp
	pop ebp
	ret
func_List_List:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword eax, [ebp - -12]
	mov dword [eax+8], 0
	mov dword [eax+4], 0
	fld dword [_108]
	fstp dword [eax+0]
	fld dword [eax+0]
	fstp dword [ebp - 4]
	fld dword [_111]
	fstp dword [eax+0]
	mov ebx, [eax+4]
	mov dword [eax+4], 0
	mov ecx, [eax+8]
	fld dword [ebp - -8]
	fstp dword [eax+0]
	mov dword [ ebp - -12], eax
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 12], ecx
	mov dword esp, ebp
	pop ebp
	ret
