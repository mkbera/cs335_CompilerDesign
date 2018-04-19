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
		_25 DD 0
		_44	DD 6.0
		_65 DD 10.0


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
	push 4
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
	mov [ebp - 4], eax
	push 4
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 16]
	push eax
	mov dword [ ebp - 16], eax
	call func_List_List
	add esp, 1* 4
	mov dword eax, 0
	; HERE
	add dword eax, 0
	mov dword ebx, [ebp - 16]
	mov dword esi, [ebp - 12]
	mov dword [esi + eax * 4], ebx
	mov dword edi, 0
	; HERE
	add dword edi, 0
	mov dword [ ebp - 20], eax
	mov dword eax, [esi + edi * 4]
	fld dword [_25]
	fstp dword [eax+0]
	mov dword [ ebp - 28], eax
	mov dword eax, 0
	; HERE
	add dword eax, 0
	mov dword [ ebp - 16], ebx
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 44], ebx
	mov dword [ ebp - 48], 0
	mov dword [ ebp - 12], esi
	mov dword [ ebp - 24], edi
	mov dword [ ebp - 36], ebx
	mov dword [ ebp - 40], eax

label_36:
	mov dword [ ebp - 52], 1
	cmp dword [ ebp - 48], 1
	jl label_40
	mov dword [ ebp - 52], 0

label_40:
	cmp dword [ ebp - 52], 0
	je label_61
	; 36
	; 36
	; float
	mov dword eax, [ebp - 36]
	fld dword [eax+0]
	fstp dword [ebp - 56]
	mov dword [ ebp - 60], 1
	fld dword [_44]
	fld dword [ebp - 56]
	fcompp
	fstsw ax
	fwait
	sahf
	mov dword [ ebp - 36], eax
	jb label_47
	mov dword [ ebp - 60], 0

label_47:
	cmp dword [ ebp - 60], 1
	je label_49
	jmp label_52

label_49:
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 32
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4

label_52:
	; 36
	; 36
	; float
	mov dword eax, [ebp - 36]
	fld dword [eax+0]
	fstp dword [ebp - 64]
	mov dword ebx, [ebp - 4]
	push ebx
	sub esp, 4
	fld dword [ebp - 64]
	fstp dword [esp]
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 36], eax
	call func_IO_print_float
	add esp, 1* 4
	mov dword eax, [ebp - 48]
	mov dword [ ebp - 68], eax
	inc dword eax
	mov dword [ ebp - 48], eax
	jmp label_36

label_61:
	mov dword esp, ebp
	pop ebp
	ret
func_List_List:
	push ebp
	mov ebp, esp
	sub esp, 4
	; -8
	; -8
	; float
	mov dword eax, [ebp - -8]
	fld dword [eax+0]
	fstp dword [ebp - 4]
	fld dword [_65]
	fstp dword [eax+0]
	mov dword [ ebp - -8], eax
	mov dword esp, ebp
	pop ebp
	ret
