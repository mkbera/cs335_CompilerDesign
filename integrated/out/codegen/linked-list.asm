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
		_88_x DD 1.0
		_88_y DD 0.0
		_93 DD 10
		_134 DD 10.0


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
	mov dword [ ebp - 12], 0
	mov dword [ ebp - 4], eax

label_24:
	mov dword eax, [ebp - 4]
	push eax
	mov dword [ ebp - 4], eax
	call func_IO_scan_float
	add esp, 1* 4
	fstp dword [ebp - 20]
	fld dword [ebp - 20]
	fistp dword [ebp - 24]
	mov dword eax, [ ebp - 24]
	mov dword [ ebp - 28], 1
	cmp dword eax, 0
	mov dword [ ebp - 12], eax
	jl label_34
	mov dword [ ebp - 28], 0

label_34:
	mov dword [ ebp - 32], 1
	cmp dword [ ebp - 12], 100
	jg label_38
	mov dword [ ebp - 32], 0

label_38:
	; HERE
	mov dword eax, [ebp - 28]
	mov dword [ ebp - 28], eax
	or dword eax, [ ebp - 32]
	cmp dword eax, 0
	mov dword [ ebp - 36], eax
	je label_42
	jmp label_24

label_42:
	push 12
	call malloc
	add esp, 4
	mov [ebp -40], eax
	fild dword [ebp - 12]
	fstp dword [ebp - 44]
	mov dword eax, [ebp - 40]
	push eax
	sub esp, 4
	fld dword [ebp - 44]
	fstp dword [esp]
	mov dword [ ebp - 40], eax
	call func_List_List
	add esp, 1* 4
	mov dword eax, [ ebp - 40]
	mov dword [ ebp - 16], eax
	mov dword [ ebp - 48], eax

label_52:
	mov dword eax, [ebp - 4]
	push eax
	mov dword [ ebp - 4], eax
	call func_IO_scan_float
	add esp, 1* 4
	fstp dword [ebp - 52]
	fld dword [ebp - 52]
	fistp dword [ebp - 56]
	mov dword eax, [ ebp - 56]
	mov dword [ ebp - 60], 1
	cmp dword eax, 0
	mov dword [ ebp - 12], eax
	jge label_62
	mov dword [ ebp - 60], 0

label_62:
	mov dword [ ebp - 64], 1
	cmp dword [ ebp - 12], 100
	jl label_66
	mov dword [ ebp - 64], 0

label_66:
	; HERE
	mov dword eax, [ebp - 60]
	mov dword [ ebp - 60], eax
	and dword eax, [ ebp - 64]
	cmp dword eax, 0
	mov dword [ ebp - 68], eax
	je label_83
	push 12
	call malloc
	add esp, 4
	mov [ebp -72], eax
	fild dword [ebp - 12]
	fstp dword [ebp - 76]
	mov dword eax, [ebp - 72]
	push eax
	sub esp, 4
	fld dword [ebp - 76]
	fstp dword [esp]
	mov dword [ ebp - 72], eax
	call func_List_List
	add esp, 1* 4
	mov dword eax, [ebp - 48]
	push eax
	mov dword ebx, [ebp - 72]
	push ebx
	mov dword [ ebp - 48], eax
	mov dword [ ebp - 72], ebx
	call func_List_set_next
	add esp, 2* 4
	mov dword ebx, [ebp - 48]
	mov eax, [ebx+8]
	mov dword ebx, eax
	mov dword [ ebp - 48], ebx
	mov dword [ ebp - 80], eax
	jmp label_52

label_83:
	mov dword eax, [ ebp - 16]
	mov dword ebx, [ebp - 4]
	push ebx
	;-1
	push 10
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 48], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword [ ebp - 84], 1

label_89:
	fld dword [_88_y]
	fld dword [_88_x]
	fcompp
	fstsw ax
	fwait
	sahf
	je label_129
	mov dword eax, [ebp - 48]
	fld dword [eax+0]
	fstp dword [ebp - 88]
	fild dword [_93]
	fstp dword [ebp - 96]
	mov dword [ ebp - 92], 1
	fld dword [ebp -96]
	mov dword [ ebp - 48], eax
	fld dword [ebp - 88]
	fcompp
	fstsw ax
	fwait
	sahf
	jb label_98
	mov dword [ ebp - 92], 0

label_98:
	cmp dword [ ebp - 92], 1
	je label_105
	mov dword eax, [ebp - 48]
	fld dword [eax+0]
	fstp dword [ebp - 100]
	mov dword ebx, [ebp - 4]
	push ebx
	sub esp, 4
	fld dword [ebp - 100]
	fstp dword [esp]
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 48], eax
	call func_IO_print_float
	add esp, 1* 4
	jmp label_113

label_105:
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 32
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 48]
	fld dword [eax+0]
	fstp dword [ebp - 104]
	mov dword ebx, [ebp - 4]
	push ebx
	sub esp, 4
	fld dword [ebp - 104]
	fstp dword [esp]
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 48], eax
	call func_IO_print_float
	add esp, 1* 4

label_113:
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword ebx, [ebp - 48]
	mov eax, [ebx+4]
	mov dword [ ebp - 112], 1
	cmp dword eax, 0
	mov dword [ ebp - 48], ebx
	mov dword [ ebp - 108], eax
	je label_122
	mov dword [ ebp - 112], 0

label_122:
	cmp dword [ ebp - 112], 1
	je label_124
	jmp label_125

label_124:
	jmp label_129

label_125:
	mov dword ebx, [ebp - 48]
	mov eax, [ebx+8]
	mov dword ebx, eax
	mov dword [ ebp - 48], ebx
	mov dword [ ebp - 116], eax
	jmp label_89

label_129:
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
	fld dword [eax+0]
	fstp dword [ebp - 4]
	fld dword [_134]
	fstp dword [eax+0]
	mov ebx, [eax+4]
	mov dword [eax+4], 0
	mov esi, [eax+8]
	fld dword [ebp - -8]
	fstp dword [eax+0]
	mov dword [ ebp - -12], eax
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 12], esi
	mov dword esp, ebp
	pop ebp
	ret
