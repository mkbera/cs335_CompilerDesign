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
		_22 DD 0
		_31 DD 0
		_37 DD 100
		_59 DD 0
		_65 DD 100
		_95 DD 10
		_136 DD 10.0


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
	fild dword [_22]
	fstp dword [ebp - 16]
	fld dword [ebp -16]
	fstp dword [ebp - 12]
	mov dword [ ebp - 4], eax

label_26:
	mov dword eax, [ebp - 4]
	push eax
	mov dword [ ebp - 4], eax
	call func_IO_scan_float
	add esp, 1* 4
	fstp dword [ebp - 24]
	fld dword [ebp -24]
	fstp dword [ebp - 12]
	fild dword [_31]
	fstp dword [ebp - 32]
	mov dword [ ebp - 28], 1
	fld dword [ebp -32]
	fld dword [ebp - 12]
	fcompp
	fstsw ax
	fwait
	sahf
	jb label_36
	mov dword [ ebp - 28], 0

label_36:
	fild dword [_37]
	fstp dword [ebp - 40]
	mov dword [ ebp - 36], 1
	fld dword [ebp -40]
	fld dword [ebp - 12]
	fcompp
	fstsw ax
	fwait
	sahf
	ja label_42
	mov dword [ ebp - 36], 0

label_42:
	; HERE
	mov dword eax, [ebp - 28]
	mov dword [ ebp - 28], eax
	or dword eax, [ ebp - 36]
	cmp dword eax, 0
	mov dword [ ebp - 44], eax
	je label_46
	jmp label_26

label_46:
	push 12
	call malloc
	add esp, 4
	mov [ebp -48], eax
	mov dword eax, [ebp - 48]
	push eax
	sub esp, 4
	fld dword [ebp - 12]
	fstp dword [esp]
	mov dword [ ebp - 48], eax
	call func_List_List
	add esp, 1* 4
	mov dword eax, [ ebp - 48]
	mov dword [ ebp - 20], eax
	mov dword [ ebp - 52], eax

label_54:
	mov dword eax, [ebp - 4]
	push eax
	mov dword [ ebp - 4], eax
	call func_IO_scan_float
	add esp, 1* 4
	fstp dword [ebp - 56]
	fld dword [ebp -56]
	fstp dword [ebp - 12]
	fild dword [_59]
	fstp dword [ebp - 64]
	mov dword [ ebp - 60], 1
	fld dword [ebp -64]
	fld dword [ebp - 12]
	fcompp
	fstsw ax
	fwait
	sahf
	jae label_64
	mov dword [ ebp - 60], 0

label_64:
	fild dword [_65]
	fstp dword [ebp - 72]
	mov dword [ ebp - 68], 1
	fld dword [ebp -72]
	fld dword [ebp - 12]
	fcompp
	fstsw ax
	fwait
	sahf
	jb label_70
	mov dword [ ebp - 68], 0

label_70:
	; HERE
	mov dword eax, [ebp - 60]
	mov dword [ ebp - 60], eax
	and dword eax, [ ebp - 68]
	cmp dword eax, 0
	mov dword [ ebp - 76], eax
	je label_85
	push 12
	call malloc
	add esp, 4
	mov [ebp -80], eax
	mov dword eax, [ebp - 80]
	push eax
	sub esp, 4
	fld dword [ebp - 12]
	fstp dword [esp]
	mov dword [ ebp - 80], eax
	call func_List_List
	add esp, 1* 4
	mov dword eax, [ebp - 52]
	push eax
	mov dword ebx, [ebp - 80]
	push ebx
	mov dword [ ebp - 52], eax
	mov dword [ ebp - 80], ebx
	call func_List_set_next
	add esp, 2* 4
	mov dword ebx, [ebp - 52]
	mov eax, [ebx+8]
	mov dword ebx, eax
	mov dword [ ebp - 52], ebx
	mov dword [ ebp - 84], eax
	jmp label_54

label_85:
	mov dword eax, [ ebp - 20]
	mov dword ebx, [ebp - 4]
	push ebx
	;-1
	push 10
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 52], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword [ ebp - 88], 1

label_91:
	cmp dword [ ebp - 88], 0
	je label_131
	mov dword eax, [ebp - 52]
	fld dword [eax+0]
	fstp dword [ebp - 92]
	fild dword [_95]
	fstp dword [ebp - 100]
	mov dword [ ebp - 96], 1
	fld dword [ebp -100]
	mov dword [ ebp - 52], eax
	fld dword [ebp - 92]
	fcompp
	fstsw ax
	fwait
	sahf
	jb label_100
	mov dword [ ebp - 96], 0

label_100:
	cmp dword [ ebp - 96], 1
	je label_107
	mov dword eax, [ebp - 52]
	fld dword [eax+0]
	fstp dword [ebp - 104]
	mov dword ebx, [ebp - 4]
	push ebx
	sub esp, 4
	fld dword [ebp - 104]
	fstp dword [esp]
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 52], eax
	call func_IO_print_float
	add esp, 1* 4
	jmp label_115

label_107:
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 32
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 52]
	fld dword [eax+0]
	fstp dword [ebp - 108]
	mov dword ebx, [ebp - 4]
	push ebx
	sub esp, 4
	fld dword [ebp - 108]
	fstp dword [esp]
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 52], eax
	call func_IO_print_float
	add esp, 1* 4

label_115:
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword ebx, [ebp - 52]
	mov eax, [ebx+4]
	mov dword [ ebp - 116], 1
	cmp dword eax, 0
	mov dword [ ebp - 52], ebx
	mov dword [ ebp - 112], eax
	je label_124
	mov dword [ ebp - 116], 0

label_124:
	cmp dword [ ebp - 116], 1
	je label_126
	jmp label_127

label_126:
	jmp label_131

label_127:
	mov dword ebx, [ebp - 52]
	mov eax, [ebx+8]
	mov dword ebx, eax
	mov dword [ ebp - 52], ebx
	mov dword [ ebp - 120], eax
	jmp label_91

label_131:
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
	fld dword [_136]
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
